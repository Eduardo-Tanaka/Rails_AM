class AddAttributesToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :person_id, :integer
    add_index :donations, :person_id
  end
end
