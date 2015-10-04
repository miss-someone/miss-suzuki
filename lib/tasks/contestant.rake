namespace :contestant do
  desc "Check new Contestant and notify"
  task check_new: :environment do
    count_file_path = Rails.root + "tmp/prev_contestant_count"
    prev_count = 0
    begin
      prev_count = File.read(count_file_path).to_i
    rescue SystemCallError => e
      puts "SystemCallError: " + e.message
    rescue IOError => e
      puts "IOError: " + e.message
    end
    current_count = ContestantProfile.count
    if current_count > prev_count
      count = current_count - prev_count
      new_contestants = ContestantProfile.limit(count).order("created_at DESC").all
      notify_to_slack(new_contestant_notify_body(new_contestants))
      File.write(count_file_path, current_count)
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
