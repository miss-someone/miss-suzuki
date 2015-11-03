class ApiController < ApplicationController
  # CircleCIから直接叩くので，CSRF対策無効
  protect_from_forgery except: :deploy

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

  private

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
