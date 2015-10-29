class VotesController < ApplicationController
  def create
    if logged_in?
      create_action_with_logged_in
    else
      create_action_with_not_logged_in
    end
  end

  private

  # ログイン済みユーザ用Voteのcreateアクション
  def create_action_with_logged_in
    if exceeded_limit_with_logged_in?
      # TODO: ログイン済ユーザ用投票上限を超えている旨表示画面へ遷移
      fail 'exceeded limitation'
    else
      # 投票可能な場合
      begin
        contestant_profile = ContestantProfile.approved.contestant_id(vote_params[:contestant_id])
        Vote.create!(voter_id: current_user.id,
                     contestant_id: vote_params[:contestant_id], group_id: group_id)
        contestant_profile.increment!(:votes, 1)
      rescue => e
        # TODO: Handling InternalServerError
        raise e.message
      end
    end
    # TODO: redirect proper path
    redirect_to contestants_thankyou_path(vote_params[:contestant_id])
  end

  # 未ログインユーザ用のcreateアクション
  def create_action_with_not_logged_in
    if exceeded_limit_with_not_logged_in?
      # TODO: 未ログインユーザ用投票上限を超えている旨表示画面へ遷移
      fail 'exceeded limitation'
    else
      begin
        Vote.transaction do
          contestant_profile = ContestantProfile.approved.contestant_id(vote_params[:contestant_id])
          Vote.create!(ip_address: request.remote_ip, cookie_token: vote_token,
                       contestant_id: vote_params[:contestant_id], group_id: contestant_profile.group_id)
          contestant_profile.increment!(:votes, 1)
        end
      rescue => e
        # TODO: Handling InternalServerError
        raise e.message
      end
    end
    # TODO: redirect proper path
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate' # HTTP 1.1.
    response.headers['Pragma'] = 'no-cache' # HTTP 1.0.
    response.headers['Expires'] = '0' # Proxies.
    redirect_to contestants_thankyou_path(vote_params[:contestant_id])
  end

  # 投票が可能かをチェック
  def can_vote?
    logged_in? ? exceeded_limit_with_logged_in? : exceeded_limit_with_not_logged_in?
  end

  # 未ログインユーザに対して，cookieとipから投票上限に達しているかチェック
  def exceeded_limit_with_not_logged_in?
    set_vote_token if vote_token.blank?
    Vote.todays_vote_count_with_no_login(request.remote_ip, vote_token) >= Settings.vote[:daily_limit][:not_logined]
  end

  # ログイン済みユーザに対して，user_idから投票上限に達しているかチェック
  def exceeded_limit_with_logged_in?
    Vote.todays_vote_count_with_login(current_user.id) >= Settings.vote[:daily_limit][:logined]
  end

  # vote_tokenをcookieにセットする
  def set_vote_token
    require 'securerandom'
    return if vote_token.present?
    cookies.signed[Settings.vote[:token_name]] = SecureRandom.uuid
  end

  # vote_tokenを取得する
  def vote_token
    cookies.signed[Settings.vote[:token_name]]
  end

  def vote_params
    params.permit(:contestant_id)
  end
end
