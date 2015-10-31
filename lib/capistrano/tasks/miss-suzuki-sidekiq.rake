################################################
#
# sidekiqをsystemdで起動するようにしたことに伴い，
# sidekiq起動系のタスクを実行しないようにしたrakeタスク
#
# generated_at: 2015/10/31
###############################################

namespace :load do
  task :defaults do
    set :sidekiq_default_hooks, -> { true }

    set :sidekiq_pid, -> { File.join('/home/webmaster/rails/miss-suzuki/shared/', 'tmp', 'pids', 'sidekiq.pid') }
    set :sidekiq_env, -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
    set :sidekiq_log, -> { File.join('/home/webmaster/rails/miss-suzuki/shared/', 'log', 'sidekiq.log') }
    set :sidekiq_timeout, -> { 10 }
    set :sidekiq_role, -> { :app }
    set :sidekiq_processes, -> { 1 }
    set :sidekiq_options_per_process, -> { nil }
    set :sidekiq_user, -> { 'webmaster' }
    # Rbenv, Chruby, and RVM integration
    set :rbenv_map_bins, fetch(:rbenv_map_bins).to_a.concat(%w(sidekiq sidekiqctl))
    set :rvm_map_bins, fetch(:rvm_map_bins).to_a.concat(%w(sidekiq sidekiqctl))
    set :chruby_map_bins, fetch(:chruby_map_bins).to_a.concat(%w{ sidekiq sidekiqctl })
    # Bundler integration
    set :bundle_bins, fetch(:bundle_bins).to_a.concat(%w(sidekiq sidekiqctl))
  end
end

namespace :sidekiq do
  def pid_process_exists?(pid_file)
    pid_file_exists?(pid_file) && test(*("kill -0 $( cat #{pid_file} )").split(' '))
  end

  def pid_file_exists?(pid_file)
    test(*("[ -f #{pid_file} ]").split(' '))
  end

  def stop_sidekiq(pid_file)
    if fetch(:stop_sidekiq_in_background, fetch(:sidekiq_run_in_background))
      if fetch(:sidekiq_use_signals)
        background "kill -TERM `cat #{pid_file}`"
      else
        background :sidekiqctl, 'stop', "#{pid_file}", fetch(:sidekiq_timeout)
      end
    else
      execute :sidekiqctl, 'stop', "#{pid_file}", fetch(:sidekiq_timeout)
    end
  end

  def quiet_sidekiq(pid_file)
    if fetch(:sidekiq_use_signals)
      background "kill -USR1 `cat #{pid_file}`"
    else
      begin
        execute :sidekiqctl, 'quiet', "#{pid_file}"
      rescue SSHKit::Command::Failed
        # If gems are not installed eq(first deploy) and sidekiq_default_hooks as active
        warn 'sidekiqctl not found (ignore if this is the first deploy)'
      end
    end
  end

  task :add_default_hooks do
    after 'deploy:starting', 'sidekiq:quiet'
    after 'deploy:updated', 'sidekiq:stop'
    after 'deploy:reverted', 'sidekiq:stop'
  end

  desc 'Quiet sidekiq (stop processing new tasks)'
  task :quiet do
    on roles fetch(:sidekiq_role) do
      switch_user do
        if test("[ -d #{release_path} ]") # fixes #11
          pid_file = fetch(:sidekiq_pid)
          quiet_sidekiq(pid_file) if pid_process_exists?(pid_file)
        end
      end
    end
  end

  desc 'Stop sidekiq'
  task :stop do
    on roles fetch(:sidekiq_role) do
      switch_user do
        if test("[ -d #{release_path} ]")
          pid_file = fetch(:sidekiq_pid)
          stop_sidekiq(pid_file) if pid_process_exists?(pid_file)
        end
      end
    end
  end

  desc 'Restart sidekiq'
  task :restart do
    invoke 'sidekiq:stop'
    # プロセスをkillすれば，systemdが再起動させてくれるのでコメントアウト
    # invoke 'sidekiq:start'
  end

  # Delete any pid file not in use
  task :cleanup do
    on roles fetch(:sidekiq_role) do
      switch_user do
        pid_file = fetch(:sidekiq_pid)
        if pid_file_exists?(pid_file)
          execute "rm #{pid_file}" unless pid_process_exists?(pid_file)
        end
      end
    end
  end

  def switch_user(&_block)
    su_user = fetch(:sidekiq_user)
    if su_user
      as su_user do
        yield
      end
    end

    yield
  end
end
