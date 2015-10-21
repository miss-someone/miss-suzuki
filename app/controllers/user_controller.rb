class UserController < ApplicationController
  def new
    @voter = Voter.new
  end

  def create
    @voter = Voter.new(user_params)
    # TODO: わかりやすいメッセージへ
    if verify_recaptcha(model: @voter, message: 'reCAPTCHAを選択してください.') && @voter.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(login_path, notice: 'メールアドレス認証が完了しました！')
    else
      not_authenticated
    end
  end

  private

  def user_params
    params.require(:voter).permit(:email, :password, :agreement)
  end
end
