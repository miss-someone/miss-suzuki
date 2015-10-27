[![Circle CI](https://circleci.com/gh/miss-someone/miss-suzuki.svg?style=svg&circle-token=7b53c034424d5b05d12282e2ec0623d38a316160)](https://circleci.com/gh/miss-someone/miss-suzuki)

#概要
ミス鈴木の開発リポジトリ

# 準備
## Bower
+ `npm install bower -g`
+ `bundle exec rake bower:install`

## Memcached
+ `brew install memcached`
+ `/usr/local/opt/memcached/bin/memcached &`

## Redis
+ `brew install redis`
+ `redis-server /usr/local/etc/redis.conf`

## Sidekiq
+ `bundle exec sidekiq -C config/sidekiq.yml`

## Mailcatcher
+ `bundle exec mailcatcher`

# 管理画面
管理画面へのアクセスには環境変数を設定する必要があります．

## 管理画面へアクセスできる形でlocalサーバーを起動する方法
次のように環境変数を設定して起動する

```
IS_ADMIN_WEB=true rails s
```
