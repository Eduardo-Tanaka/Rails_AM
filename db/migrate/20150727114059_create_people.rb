class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :status, limit: 1
      t.string :user_name, limit: 50
      t.integer :ranking
      t.string :name, limit: 100
      t.string :cpf, limit: 15
      t.string :rg, limit: 15
      t.datetime :birth_date
      t.string :company_name, limit: 128
      t.string :trading_name, limit: 128
      t.string :cnpj, limit: 18

      t.timestamps null: false
    end
  end
end
