namespace :report do
  desc "Report yesterday's vote count to slack"
  task check_yesterdays_vote_count: :environment do
    notify_to_slack_for_report(vote_count_notify_body)
    notify_to_slack_for_report(user_count_notify_body)
  end

  def vote_count_notify_body
    yesterdays_count = Vote.where(created_at:
                                  (Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day)).count
    all_count = Vote.count
    attachments = []
    attachment = {
      fallback: "昨日の投票総数をご報告!",
      pretext: "昨日の投票総数をご報告！",
      text: "今日も頑張りましょう〜！",
      color: "#F6546A",
      fields: [{
        title: "昨日の投票総数",
        value: "#{yesterdays_count} 票！"
      }, {
        title: "今までの投票総数",
        value: "#{all_count} 票！"
      }]
    }
    attachments.push(attachment)
    { attachments: attachments }.to_json
  end

  def user_count_notify_body
    yesterdays_count = Voter.where(created_at:
                                  (Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day)).count
    all_count = Voter.count
    attachments = []
    attachment = {
      fallback: "続いて，昨日の会員登録総数をご報告!",
      pretext: "続いて，昨日の会員登録総数をご報告!",
      color: "#F6546A",
      fields: [{
        title: "昨日の会員登録総数",
        value: "#{yesterdays_count} 人！"
      }, {
        title: "今までの会員登録総数",
        value: "#{all_count} 人！"
      }]
    }
    attachments.push(attachment)
    { attachments: attachments }.to_json
  end

  def notify_to_slack_for_report(body_json)
    api_url = 'https://hooks.slack.com/services/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'
    uri = URI.parse(api_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)

    req["Content-Type"] = "application/json"
    req.body = body_json
    https.request(req)
  end
end
