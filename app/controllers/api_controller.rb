class ApiController < ApplicationController
  # CircleCIから直接叩くので，CSRF対策無効
  protect_from_forgery except: [:deploy, :reborn]

  # CircleCIからのwebhookを受け取ってデプロイを行うアクション
  def deploy
    unless deploy_request_is_valid?(params)
      notify_invalid_request_received
      return head 403
    end
    # テスト成功以外はデプロイしない
    return head 200 unless params[:payload][:status] == "success"

    # masterブランチor developブランチの時のみデプロイを行う
    case params[:payload][:branch]
    when "master"
      AutomaticDeployJob.perform_later("production")
    when "develop"
      AutomaticDeployJob.perform_later("staging")
    end
    head 200
  end

  def reborn
    return head 403 if params[:id].nil?
    target = params[:id].to_i
    return head 403 unless target.between?(1,2)
    return head 403 unless verify_reborn_token(params[:token])

    stdout, stderr, status_code = do_reborn(target)    

    render json: gen_reborn_response(target, stdout, stderr, status_code)
  end

  private

  def do_reborn(target)
    require 'open3'
    reborn_cmd = "/home/webmaster/bin/restart_unicorn#{target}.sh"
    result = Open3.capture3(reborn_cmd)
    [result[0], result[1], (result[2].success? ? 0 : 1)]
  end

  def verify_reborn_token(token)
    ["vYLH4tDtgnlSRlQyXEsHKOW1", "SUeKoZXBkX1Y3HZKf4lhiukR"].include?(token)
  end

  def gen_reborn_response(target, stdout, stderr, status_code)
    attachments = { fields: [] }
    result = { title: "Deploy Result" }
    attachments[:fields].push(result)
    attachments[:fallback] = "[Unicorn#{target}]ヒヒーン"
    attachments[:pretext] = "[Unicorn#{target}]ヒヒーン"
    attachments[:color] = "#41AA58"
    result[:value] = "Result"
    normal_log = { title: "Std Log", value: stdout }
    err_log = { title: "Error log", value: stderr }
    attachments[:fields].push(normal_log)
    attachments[:fields].push(err_log)
    { attachments: [attachments] }
  end

  # デプロイ要求の正当性検証
  def deploy_request_is_valid?(params)
    # デプロイキー検証
    return false if params[:key] != Settings.deploy_info[:key]
    # リポジトリ検証
    return false if params[:payload][:vcs_url] != Settings.deploy_info[:vcs_url]

    true
  end

  def notify_invalid_request_received
    # not implemented
    # TODO: 実装する
  end
end
