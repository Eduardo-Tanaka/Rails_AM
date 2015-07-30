class AddPersonIdToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :person_id, :integer
    add_index :phones, :person_id
  end
end
