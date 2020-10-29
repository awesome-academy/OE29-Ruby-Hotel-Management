class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailers.user_mailer.account_activation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailers.user_mailer.password_reset")
  end

  def reservation_activation user, bill
    @user = user
    @bill = bill
    mail to: user.email,
         subject: t("mailers.user_mailer.reservation_activation")
  end
end
