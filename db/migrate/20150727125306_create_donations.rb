class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :title, limit: 60
      t.text :description
      t.string :situation, limit: 20
      t.string :status, limit: 1

      t.timestamps null: false
    end
  end
end
