class UsersWorker
  include Sidekiq::Worker

  def perform bill_id
    bill = Bill.find bill_id
    user = bill.user
    UserMailer.reservation_activation(user, bill).deliver_now
  end
end
