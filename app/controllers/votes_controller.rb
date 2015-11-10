class VotesController < ApplicationController
  skip_before_filter :require_login, only: [:create]

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
    @contestant_profile = ContestantProfile.approved.current_open_group.contestant_id(vote_params[:contestant_id])
    if exceeded_limit_with_logged_in?(@contestant_profile)
      render 'exceeded_limitation'
    else
      # 投票可能な場合
      begin
        Vote.transaction do
          Vote.create!(voter_id: current_user.id,
                       contestant_id: vote_params[:contestant_id], group_id: @contestant_profile.group_id)
          @contestant_profile.increment!(:votes, 1)
        end
        # 投票成功時には，thankyouページヘ
        redirect_to contestants_thankyou_path(vote_params[:contestant_id])
      rescue => e
        # 通常，ありえないので500を返す
        raise e.message
      end
    end
  end

  # 未ログインユーザ用のcreateアクション
  def create_action_with_not_logged_in
    @contestant_profile = ContestantProfile.approved.current_open_group.contestant_id(vote_params[:contestant_id])
    if exceeded_limit_with_not_logged_in?(@contestant_profile)
      render 'exceeded_limitation'
    else
      begin
        Vote.transaction do
          Vote.create!(ip_address: request.remote_ip, cookie_token: vote_token,
                       contestant_id: vote_params[:contestant_id], group_id: @contestant_profile.group_id)
          @contestant_profile.increment!(:votes, 1)
        end
        # 投票成功時には，thankyouページヘ
        redirect_to contestants_thankyou_path(vote_params[:contestant_id])
      rescue => e
        # 通常，ありえないので500を返す
        raise e.message
      end
    end
  end

  # 未ログインユーザに対して，cookieとipから投票上限に達しているかチェック
  def exceeded_limit_with_not_logged_in?(contestant_profile)
    set_vote_token if vote_token.blank?
    count = Vote.todays_vote_count_with_no_login(request.remote_ip, vote_token, contestant_profile.group_id)
    count >= Settings.vote[:daily_limit][:not_logined]
  end

  # ログイン済みユーザに対して，user_idから投票上限に達しているかチェック
  def exceeded_limit_with_logged_in?(contestant_profile)
    count = Vote.todays_vote_count_with_login(current_user.id, contestant_profile.group_id)
    count >= Settings.vote[:daily_limit][:logined]
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
