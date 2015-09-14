# Unicorn設定ファイル

# railsアプリのルートディレクトリ
def rails_root
  require "pathname"
  Pathname.new(__FILE__) + "../../"
end

# ワーカープロセス．CPUの数より少し多いぐらい
worker_processes 3

# railsの応答待機時間
timeout 30

# ダウンタイム無し
preload_app true

# リクエストを受け付けるポート番号
listen 3200

# pidファイルの場所
# Capistranoで設定したpidのファイル箇所と一緒で有ること
pid "#{rails_root}/tmp/pids/unicorn.pid"

before_fork do |server, _worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      # 古いマスターには死んでもらう
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts 'no previous worker is found'
    end
  end

  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end

stderr_path File.expand_path('log/unicorn-err.log', rails_root)
stdout_path File.expand_path('log/unicorn-std.log', rails_root)
