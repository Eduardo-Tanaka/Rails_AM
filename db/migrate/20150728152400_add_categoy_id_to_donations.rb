class AddCategoyIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :category_id, :integer
    add_index :donations, :category_id
  end
end
