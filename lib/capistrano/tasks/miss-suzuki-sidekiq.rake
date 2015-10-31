################################################
#
# sidekiqをsystemdで起動するようにしたことに伴い，
# sidekiq起動系のタスクを実行しないようにしたrakeタスク
#
# generated_at: 2015/10/31
###############################################

namespace :deploy do
  before :starting, :check_sidekiq_hooks do
    invoke 'sidekiq:add_default_hooks' if fetch(:sidekiq_default_hooks)
  end
  after :publishing, :restart_sidekiq do
    invoke 'sidekiq:restart' if fetch(:sidekiq_default_hooks)
  end
end

namespace :sidekiq do
  def for_each_process(reverse = false, &_block)
    pids = processes_pids
    pids.reverse! if reverse
    pids.each_with_index do |pid_file, idx|
      within release_path do
        yield(pid_file, idx)
      end
    end
  end

  def processes_pids
    pids = []
    sidekiq_roles = Array(fetch(:sidekiq_role))
    sidekiq_roles.each do |role|
      next unless host.roles.include?(role)
      processes = fetch(:"#{ role }_processes") || fetch(:sidekiq_processes)
      processes.times do |idx|
        pids.push fetch(:sidekiq_pid).gsub(/\.pid$/, "-#{idx}.pid")
      end
    end

    pids
  end

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
          for_each_process(true) do |pid_file, _idx|
            quiet_sidekiq(pid_file) if pid_process_exists?(pid_file)
          end
        end
      end
    end
  end

  desc 'Stop sidekiq'
  task :stop do
    on roles fetch(:sidekiq_role) do
      switch_user do
        if test("[ -d #{release_path} ]")
          for_each_process(true) do |pid_file, _idx|
            stop_sidekiq(pid_file) if pid_process_exists?(pid_file)
          end
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
        for_each_process do |pid_file, _idx|
          if pid_file_exists?(pid_file)
            execute "rm #{pid_file}" unless pid_process_exists?(pid_file)
          end
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

  def upload_sidekiq_template(from, to, role)
    template = sidekiq_template(from, role)
    upload!(StringIO.new(ERB.new(template).result(binding)), to)
  end

  def sidekiq_template(name, role)
    local_template_directory = fetch(:sidekiq_monit_templates_path)

    search_paths = [
      "#{name}-#{role.hostname}-#{fetch(:stage)}.erb",
      "#{name}-#{role.hostname}.erb",
      "#{name}-#{fetch(:stage)}.erb",
      "#{name}.erb"
    ].map { |filename| File.join(local_template_directory, filename) }

    global_search_path = File.expand_path(
      File.join(*%w(.. .. .. generators capistrano sidekiq monit templates), "#{name}.conf.erb"),
      __FILE__
    )

    search_paths << global_search_path

    template_path = search_paths.detect { |path| File.file?(path) }
    File.read(template_path)
  end
end
