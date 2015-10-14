class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url
    else
      flash.now.alert = "メールアドレスかパスワードが間違っています。"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end