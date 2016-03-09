class IdolMailer < ApplicationMailer
  def idol_confirm_email(idol)
    @idol = idol
    mail(to: @idol.email, subject: "説明会へのご参加を受け付けました。")
  end

  def idol_confirm_admin_email(idol)
    @idol = idol
    mail(to: 'ms.someone2015@gmail.com', subject: 'アイドルの申し込みが有ったよ!')
  end
end
