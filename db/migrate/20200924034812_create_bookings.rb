class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.integer :price
      t.integer :status
      t.datetime :checkin
      t.datetime :checkout
      t.references :bill, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
