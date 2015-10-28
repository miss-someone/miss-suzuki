source 'https://rubygems.org'

ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# jQuery使う
gem 'jquery-rails'
# Jsパッケージの管理
gem 'bower-rails', '~> 0.10.0'
# Sassを使えるようにする
gem 'sass-rails', '~> 5.0'
# Sassの拡張
gem 'compass-rails'
# JSの圧縮
gem 'uglifier', '>= 1.3.0'
# JSONレスポンスを効率的に書ける
gem 'jbuilder', '~> 2.0'
# DBでPostgreSQLを使う
gem 'pg'
# 認証処理周りを担ってくれる(deviseより単純)
gem 'sorcery', '~>0.9.1'
# 定数管理
gem 'config'
# 多言語対応用のgem(今回は多言語対応しないが，デフォルト言語を日本語にするため利用
gem 'rails-i18n'
# 画像アップロード用のgem
gem 'carrierwave'
# 画像アップロード時にクロップするgem
gem 'carrierwave-crop'
# carrierwaveのアップロードをバックグラウンドで行うgem
gem 'carrierwave_backgrounder'
# Cloudinaryとの連携用
gem 'cloudinary'
# アプリケーションサーバ
gem 'unicorn'
# アナリティクス
gem 'google-analytics-rails'
# 管理画面
gem 'activeadmin', github: 'activeadmin'
# 管理画面におけるユーザ管理
gem 'devise'
# cron
gem 'whenever', require: false
# プロファイラサービス
gem 'newrelic_rpm'
# 稼働環境をラベルで表示してくれるすぐれもの
gem "rack-dev-mark"
# セッションストアとして使うmemcachedクライアント
gem 'dalli'
# GoogleのreCAPTCHAapiのhelpergem
gem "recaptcha", require: "recaptcha/rails"
# ハッシュをActiveRecordライクに扱えるようにするgem
gem 'active_hash'
# 都道府県扱う用gem
gem 'jp_prefecture'
# 非同期ジョブを扱うgem
gem 'sidekiq'
# sidekiqのWebUIに必要
gem 'sinatra', require: false

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Railsのベストプラクティスを教えてくれる
  gem 'rails_best_practices'
  # 余分なSQL(N+1問題等)を検出してくれる
  gem 'bullet'
  # ER図を吐き出してくれる
  gem 'rails-erd'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem "spring-commands-rspec"

  # 仮想SMTPサーバ
  gem 'mailcatcher'

  # debug
  # エラー画面をリッチに
  gem 'better_errors'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # railsでpryが使える
  gem 'pry-rails'
  # pryでデバックコマンドが使える
  gem 'pry-byebug'
  # コーディング規約チェック
  gem 'rubocop', require: false

  # 複数プロセスの管理ツール
  gem 'foreman'

  # 自動デプロイ用
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
  gem 'capistrano-sidekiq'
end

group :test do
  gem 'rspec'                  # テストツール
  gem 'rspec-rails'            # RailsでRspecが使える
  gem 'factory_girl_rails'     # テストデータの生成
  gem 'database_cleaner'       # テスト実行後にDBをクリア
  gem 'capybara'               # ブラウザでの操作をシミュレートしてテストができる
end
