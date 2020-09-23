class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
