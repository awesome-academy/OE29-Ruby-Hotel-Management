class ChangeGenderInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :gender, :integer, null: false, default: 0
  end
end
