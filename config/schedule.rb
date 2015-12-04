# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
require File.expand_path(File.dirname(__FILE__) + "/environment")

set :output, Rails.root + "log/cron.log"

if Rails.env.production? && ENV['IS_ADMIN_WEB'] != 'true'
  # プレ公開出場者のアップデートを，毎日0:01に行う
  # 実行するのは，マイグレーションを行うアプリケーションサーバ上
  # every 1.day, at: '0:01 am' do
  #  rake "contestant:update_todays_preopens"
  # end
end

if Rails.env.production? && ENV['IS_ADMIN_WEB'] == 'true'
  # 5分ごとに新着応募者チェック
  every '*/5 6-23 * * *' do
    rake "contestant:check_new"
  end
  every '*/5 5 * * *' do
    rake "domain:check_new_domain"
  end
  every 1.day, at: '0:01am' do
    rake "report:check_yesterdays_vote_count"
  end
end
