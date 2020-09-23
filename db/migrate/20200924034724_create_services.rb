class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :price
      t.text :des
      t.references :unity, foreign_key: true

      t.timestamps
    end
  end
end
