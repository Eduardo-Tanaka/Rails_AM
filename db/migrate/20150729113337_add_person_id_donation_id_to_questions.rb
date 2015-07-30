class AddPersonIdDonationIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :person_id, :integer
    add_index :questions, :person_id
    add_column :questions, :donation_id, :integer
    add_index :questions, :donation_id
  end
end
