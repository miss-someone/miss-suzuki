namespace :sidekiq do
  desc "Stop sidekiq"
  task :stop do
    sidekiq_signal :QUIT
  end

  def sidekiq_signal(signal)
    Process.kill signal, sidekiq_pid
  end

  def sidekiq_pid
    File.read(Rails.root + "tmp/pids/sidekiq.pix").to_i
  rescue Errno::ENOENT
    raise "Sidekiq doesn't seem to be running"
  end
end
