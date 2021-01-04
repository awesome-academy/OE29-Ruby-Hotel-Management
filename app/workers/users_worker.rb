class UsersWorker
  include Sidekiq::Worker

  def perform bill_id
    bill = Bill.find bill_id
    UserMailer.reservation_activation(bill.user, bill).deliver_now
  rescue StandardError => e
    AdminMailer.reservation_error(bill_id).deliver_now
    raise e
  end
end
