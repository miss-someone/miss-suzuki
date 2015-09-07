source 'https://rubygems.org'

ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# jQuery使う
gem 'jquery-rails'
# ページ遷移をajax的にしてくれるやつだった気がする
gem 'turbolinks'
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

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

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

  # debug
  # エラー画面をリッチに
  gem 'better_errors'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # railsでpryが使える
  gem 'pry-rails'
  # pryでデバックコマンドが使える
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'                  # テストツール
  gem 'rspec-rails'            # RailsでRspecが使える
  gem 'factory_girl_rails'     # テストデータの生成
  gem 'database_cleaner'       # テスト実行後にDBをクリア
  gem 'capybara'               # ブラウザでの操作をシミュレートしてテストができる
end
