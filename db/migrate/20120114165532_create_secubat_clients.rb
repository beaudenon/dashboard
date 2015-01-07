class CreateSecubatClients < ActiveRecord::Migration
  def change
    create_table :secubat_clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :entreprise
      t.text :description

      t.timestamps
    end
  end
end
