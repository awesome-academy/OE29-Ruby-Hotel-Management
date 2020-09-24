class CreateBookingServices < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_services do |t|
      t.integer :amount
      t.references :booking, foreign_key: true
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
