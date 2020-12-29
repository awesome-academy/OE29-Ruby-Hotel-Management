class AdminMailer < ApplicationMailer
  def reservation_error bill_id
    @bill = bill_id
    mail to: ENV["mail_admin"],
         subject: t("mailers.admin_mailer.reservation_error", bill: @bill)
  end
end
