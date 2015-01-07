class CreateSecubatMailings < ActiveRecord::Migration
  def change
    create_table :secubat_mailings do |t|
      t.references  :secubat_client
      t.references  :secubat_model
      t.datetime    :sent_at
      t.timestamps
    end
    add_foreign_key :secubat_mailings, :secubat_clients
    add_foreign_key :secubat_mailings, :secubat_models
  end
end
