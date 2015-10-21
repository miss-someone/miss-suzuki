class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @activation_url = "#{Settings.url_without_path}users/#{user.activation_token}/activate"
    mail(to: user.email, subject: "ミス鈴木への会員登録ありがとうございます！")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
    @user = user
    @login_url = "#{Settings.url_without_path}login"
    mail(to: user.email, subject: "メールアドレス認証が完了いたしました．")
  end
end
