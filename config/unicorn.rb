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

before_fork do |server, worker|
  old_pid = "#{ server.config[:pid] }.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      # 古いマスターには死んでもらう
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # some
    end
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

stderr_path File.expand_path('log/unicorn-err.log', rails_root)
stdout_path File.expand_path('log/unicorn-std.log', rails_root)
