class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  # パスワードリセットのリクエスト生成
  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to(login_path, notice: 'パスワード再設定メールを送信致しました．ご確認ください')
  end

  # パスワードリセットを行うフォーム
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return if @user.present?

    not_authenticated
  end

  # パスワードリセット
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    if @user.change_password!(user_params[:password])
      redirect_to(login_path, notice: 'パスワードが正常にリセットされました! 引き続きミス鈴木をお楽しみください!')
    else
      render action: 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
