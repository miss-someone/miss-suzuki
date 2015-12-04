namespace :domain do
  desc 'Report when new domain is detected'
  task check_new_domain: :environment do
    result = new_domains

    if result.present?
      print result
      notify_to_slack_for_new_domains(new_domains_detected_body(result))
      result.each { |d| EmailDomain.create(domain: d['domain']) }
    end
  end

  def new_domains
    sql = ActiveRecord::Base.send(
      :sanitize_sql_array, 
      ["SELECT domain, count
        FROM (
          SELECT substring(email from '@(.+)$') as domain, count(email) as count
          FROM users
          GROUP BY domain
          ) as not_registred_domains
        WHERE domain not in (?) and count >= ?;
        ", EmailDomain.domains, Settings.new_domain_notification_threshold]
    )
    ActiveRecord::Base.connection.select_all(sql).to_hash
  end

  def new_domains_detected_body(domains)
    fields = new_domain_fields(domains)
    {
      attachments: [
        {
          fallback: 'Registered new domains',
          pretext: 'Registered new domains',
          color: "#F6546A",
          fields: fields
        }
      ]
    }.to_json
  end

  def new_domain_fields(domains)
    domains.each_with_object([]) do |domain, arr|
      arr << {
        title: domain['domain'],
        value: domain['count'],
        short: false
      }
    end
  end

  def notify_to_slack_for_new_domains(body_json)
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
