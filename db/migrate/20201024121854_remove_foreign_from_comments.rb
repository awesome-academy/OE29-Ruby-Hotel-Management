class RemoveForeignFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :rating, :integer
    remove_column :comments, :room_id, :integer
  end
end
