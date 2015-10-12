# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'miss-suzuki'
set :repo_url, 'git@github.com:miss-someone/miss-suzuki.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# デプロイ先のディレクトリ
set :deploy_to, '/home/webmaster/rails/miss-suzuki'

# アセットディレクトリを置くリバプロのディレクトリ
set :assets_to, '/usr/share/nginx/html/miss-suzuki'

# ログレベル(:info or :debug)
set :log_level, :debug

# sudoが使いたいときはtrueにしましょう(default: false)
# set :pty, true

# 公開したくないファイルをシンボリックリンクとして作成
# 今回はプライベートリポジトリを使用しているため，何もしない
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# 保存するリビジョン数
set :keep_releases, 5

# 使うrbenv
set :rbenv_type, :system
# 使うrubyのバージョン
set :rbenv_ruby, '2.2.2'

# rbenvのインストールパス
set :rbenv_custom_path, '/home/webmaster/.rbenv'
# rbenvを実行する際の設定
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# ???
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value

# Unicornのpidファイルの場所
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
# Unicornのconfigファイルの場所
set :unicorn_config_path, "#{File.join(current_path, 'config', 'unicorn.rb')}"

# bundle installの並列実行(アプリケーションサーバのコア数まで
set :bundle_jos, 2

# wheneverのジョブ識別用のid指定
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :copy_assets do
    # アセットのコピーをとりあえず，無理やり
    sh "scp -rC public/assets 192.168.1.11:#{fetch(:assets_to)}"
    sh "scp -rC public/assets 192.168.1.12:#{fetch(:assets_to)}"
    # スケール用
    # sh "scp -rC public/assets 192.168.1.13:#{fetch(:assets_to)}"
  end
  task :restart do
    invoke 'unicorn:restart'
  end
end
