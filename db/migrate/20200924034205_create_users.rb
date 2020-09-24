class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.integer :age
      t.text :address
      t.string :email
      t.integer :gender
      t.integer :role

      t.timestamps
    end
  end
end
