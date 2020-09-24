class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :price
      t.text :des
      t.references :view, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
