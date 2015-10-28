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
    unless exceeded_limit_with_logged_in?
      params = vote_params
      begin
        Vote.create!(user_id: current_user.id,
                     contestant_id: vote_params[:id], group_id: vote_params[:group_id])
        Contestant.find(params[:contestant_id]).increment!(:votes, 1)
      rescue
        # TODO: Handling InternalServerError
        fail "error"
      end
    else
      # TODO: ログイン済ユーザ用投票上限を超えている旨表示画面へ遷移
    end
  end

  # 未ログインユーザ用のcreateアクション
  def create_action_with_not_logged_in
    unless exceeded_limit_with_not_logged_in?
      begin
        Vote.transaction do
          Vote.create!(ip_address: request.remote_ip, cookie_token: vote_token,
                       contestant_id: vote_params[:id], group_id: vote_params[:group_id])
          Contestant.find(params[:contestant_id]).increment!(:votes, 1)
        end
      rescue
        # TODO: Handling InternalServerError
        fail "error"
      end
    else
      # TODO: 未ログインユーザ用投票上限を超えている旨表示画面へ遷移
    end
  end

  # 投票が可能かをチェック
  def can_vote?
    logged_in? ? exceeded_limit_with_logged_in? : exceeded_limit_with_not_logged_in?
  end

  # 未ログインユーザに対して，cookieとipから投票上限に達しているかチェック
  def exceeded_limit_with_not_logged_in?
    set_vote_token if vote_token.blank?
    Voter.todays_vote_count_with_no_login(request.remote_ip, vote_token) >= Settings.vote[:daily_limit][:not_logined]
  end

  # ログイン済みユーザに対して，user_idから投票上限に達しているかチェック
  def exceeded_limit_with_logged_in?
    Voter.todays_vote_count_with_login(current_user.id) >= Settings.vote[:daily_limit][:logined]
  end

  # vote_tokenをcookieにセットする
  def set_vote_token
    require 'securerandom'
    return if vote_token.present?
    cokkies.signed[Settings.vote[:token_name]] = SecureRandom.uuid
  end

  # vote_tokenを取得する
  def vote_token
    cookies.signed[Settings.vote[:token_name]]
  end
  
  def vote_params
    params.permit(:id, :group_id)
  end
end
