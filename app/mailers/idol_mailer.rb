class IdolMailer < ApplicationMailer
  def idol_confirm_email(idol)
    @idol = idol
    mail(to: @idol.email, subject: "説明会へのご参加を受け付けました。")
  end
end
