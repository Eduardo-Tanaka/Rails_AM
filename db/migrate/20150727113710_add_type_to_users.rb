class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :des_type, :string, limit: 1
  end
end
