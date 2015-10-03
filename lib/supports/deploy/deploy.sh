#!/bin/bash -p

##############################
# webmaster権限で動作させること
# sudo -u webmaster -H -i env deploy.sh [env]
# あらかじめsudoersの設定が必要
# apache ALL=(webmaster) /home/webmaster/bin/miss-suzuki-deploy.sh
##############################

export RAILS_ROOT='/home/webmaster/rails/miss-suzuki/'

# どこかでエラーが起きたら中断
set -e

if [ $# -ne 1 ] ; then
  echo "must only specify target environment[production or staging]." 1>&2
  exit 1
fi

target_env=$1
target_branch=""

if [ $1 = "production" ] ; then
  target_branch="master"
elif [ $1 = "staging" ] ; then
  target_branch="develop"
  echo "deployment to staging environment is not implemented now." 1>&2
  exit 1
else
  echo "invalid target_env" 1>&2
  exit 1
fi

cd $RAILS_ROOT
echo "start to deploy. (target environment is $target_env)"

# リポジトリの情報更新
# リポジトリを一旦クリーンアップ, 古いアセット類を削除する
echo "cleaning up repository"
git reset --hard
git clean -df
# 最新のtarget_branchに追随
echo "updating repository"
git checkout $target_branch
git fetch
git merge origin/$target_branch
# gem及びjsライブラリのinstall
echo "updating libraries"
bundle install --path vendor/bundle
bundle exec rake bower:install
# asset類の準備
echo "prepare assets"
bundle exec rake assets:precompile
git add public/assets/manifest-* # manifestファイルのみ管理対象に追加
git commit -m 'precompile [ci skip]'
git push origin $target_branch

# DBのseed情報書き込み
echo "running seed"
bundle exec rake db:seed

# デプロイ
echo "deploying..."
bundle exec cap $target_env deploy:copy_assets
bundle exec cap $target_env deploy
# bundle exec cpa $target_env restart # うまく再起動しなかったら入れる

echo "successfully finished deployment"
