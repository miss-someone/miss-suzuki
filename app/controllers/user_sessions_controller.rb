class UserSessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      if should_create_profile?(user)
        redirect_to new_user_profile_path
      else
        redirect_back_or_to root_url
      end
    else
      flash.now.alert = "メールアドレスかパスワードが間違っています。"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def should_create_profile?(user)
    user.voter? && user.profile.blank?
  end
end
