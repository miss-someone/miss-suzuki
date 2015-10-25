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
    @interview_answers = InterviewTopic.each_with_object([]) do |topic, res|
      res << InterviewAnswer.new(user_id: user.id, topic_id: topic.id)
    end
    @user = user
    @login_url = "#{Settings.url_without_path}login"
    mail(to: user.email, subject: "メールアドレス認証が完了いたしました．")
  end

  def reset_password_email(user)
    @user = User.find user.id
    @reset_url = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: "パスワード再設定のご案内")
  end
end
