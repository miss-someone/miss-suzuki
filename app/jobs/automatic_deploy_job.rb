# 自動デプロイを行うクラス
class AutomaticDeployJob < ActiveJob::Base
  queue_as :default

  def perform(target)
    do_deploy(target)
  end

  def do_deploy(target)
    return unless %w(production staging).include? target
    msg, errmsg, status_code = exec_deploy_cmd(target)
    output_log(msg, errmsg)
    notify_to_slack(target, status_code, msg, errmsg)
  end

  # デプロイスクリプトの実行
  # return: [標準出力，標準エラー出力，完了ステータス(成功:0, 失敗:1)
  def exec_deploy_cmd(target)
    require 'open3'
    deploy_cmd = "#{Settings.deploy_info[:command]} #{target}"
    result = Open3.capture3(deploy_cmd)
    [result[0], result[1], (result[2].success? ? 0 : 1)]
  end

  # デプロイのログを記録する
  def output_log(msg, errmsg)
    std_logger = ActiveSupport::Logger.new(Rails.root.join("log/automatic_deploy.log"), 3, 5.megabytes)
    err_logger = ActiveSupport::Logger.new(Rails.root.join("log/automatic_deploy_err.log"), 3, 5.megabytes)
    std_logger.formatter = ::Logger::Formatter.new
    err_logger.formatter = ::Logger::Formatter.new
    std_logger.info msg
    err_logger.info errmsg
  end

  # Slackへの結果通知
  def notify_to_slack(target, status_code, msg, errmsg)
    attachments = { fields: [] }
    result = { title: "Deploy Result" }
    attachments[:fields].push(result)
    if status_code == 0
      attachments[:fallback] = "[#{target}]デプロイせいこう＼(^o^)／"
      attachments[:pretext] = "[#{target}]デプロイせいこう＼(^o^)／"
      attachments[:color] = "#41AA58"
      result[:value] = "Success!"
    else
      attachments[:fallback] = "[#{target}]デプロイしっぱい(´・ω・｀)"
      attachments[:pretext] = "[#{target}]デプロイしっぱい(´・ω・｀)"
      attachments[:color] = "#D00000"
      result[:value] = "Failed..."
      normal_log = { title: "Std Log", value: log_tail(msg, 30) }
      err_log = { title: "Error log", value: log_tail(errmsg, 30) }
      attachments[:fields].push(normal_log)
      attachments[:fields].push(err_log)
    end
    post_json(Settings.deploy_info[:slack_webhook_url], { attachments: [attachments] }, true)
  end

  def log_tail(logmsg, size)
    lines = logmsg.lines
    return logmsg if lines.size <= size
    lines.reverse.slice(0..size).reverse.join("")
  end

  def post_json(url, data, isSSL)
    require 'net/http'
    require 'uri'
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = isSSL
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    req.body = data.to_json
    http.request(req)
  end
end
