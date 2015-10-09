namespace :contestant do
  desc "Check new Contestant and notify"
  task check_new: :environment do
    prev_last_id_file_path = Rails.root + "tmp/prev_last_contestant_id"
    prev_last_id = 0
    begin
      prev_last_id = File.read(prev_last_id_file_path).to_i
    rescue SystemCallError => e
      puts "SystemCallError: " + e.message
    rescue IOError => e
      puts "IOError: " + e.message
    end
    new_contestants = ContestantProfile.where("id > ?", prev_last_id)
    if new_contestants.present?
      last_id = ContestantProfile.last.id
      notify_to_slack(new_contestant_notify_body(new_contestants))
      File.write(prev_last_id_file_path, last_id)
    end
  end

  desc "Update todays preopen contestants"
  task update_todays_preopens: :environment do
    # 既存のプレオープン出場者の解除
    olds = Contestant.todays_preopen
    olds.each do |contestant|
      contestant.profile.update_attribute(:is_preopen, false)
    end

    # 新しいプレオープン出場者の選定(承認済みユーザのみ)
    news = Contestant.approved.random Settings.contestant[:preopen_count]
    news.each do |contestant|
      contestant.profile.update_attribute(:is_preopen, true)
    end
  end

  def notify_to_slack(body_json)
    api_url = 'https://hooks.slack.com/services/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'
    uri = URI.parse(api_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)

    req["Content-Type"] = "application/json"
    req.body = body_json
    https.request(req)
  end

  def new_contestant_notify_body(contestants)
    attachments = []
    contestants.each do |contestant|
      attachment = {
        fallback: "新しい応募者が現れた!",
        pretext: "新しい応募者が現れた！: <http://59.106.216.27/miss-suzuki/admin/contestant_profiles/#{contestant.id}|link>",
        color: "#F6546A",
        fields: get_fields(contestant),
        thumb_url: contestant.profile_image.thumb
      }
      attachments.push(attachment)
    end
    body = {
      attachments: attachments
    }
    body.to_json
  end

  def get_fields(contestant)
    [{
      title: "名前",
      value: contestant.name,
      short: false
    }, {
      title: "年齢",
      value: contestant.age,
      short: false
    }, {
      title: "コメント",
      value: contestant.comment,
      short: false
    }, {
      title: "どうやって知りましたか？",
      value: contestant.how_know,
      short: false
    }]
  end
end
