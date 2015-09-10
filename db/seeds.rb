# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# タグ用のseed
tags = ["0-9歳", "10代", "20代", "30代", "40代", "50歳以上", "大学生",
  "高校生", "中学生"]
tags.each do |tag|
  ContestantTag.create({name: tag})
end
