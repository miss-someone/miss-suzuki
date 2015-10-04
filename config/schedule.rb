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

if Rails.env.production?
  # プレ公開出場者のアップデートを，毎日0:01に行う
  every 1.day, at: '0:01 am' do
    rake "contestant:update_todays_preopens"
  end
end

if Rails.env.production? && ENV['IS_ADMIN_WEB'] == true
  # 新着応募者のチェックタスク
  every '0,30 6-23 * * *' do
    rake "contestant:check_new"
  end
end
