class AddDonationIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :donation_id, :integer
    add_index :photos, :donation_id
  end
end
