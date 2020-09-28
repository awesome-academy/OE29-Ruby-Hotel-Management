class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.integer :room_id
      t.string :picture

      t.timestamps
    end
  end
end
