class AdminMailer < ApplicationMailer
  def reservation_error
    mail to: "trantieucuc@gmail.com", subject: t("mailers.user_mailer.account_activation")
  end
end