class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :number, limit: 10
      t.string :zipcode, limit: 9
      t.string :neighborhood, limit: 128
      t.string :city, limit: 128
      t.string :state, limit: 128
      t.string :complement, limit: 128

      t.timestamps null: false
    end
  end
end
