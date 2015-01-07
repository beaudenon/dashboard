class AddGenderToSecubatClients < ActiveRecord::Migration
  def up
    add_column :secubat_clients, :gender, "ENUM('monsieur', 'madame')", :default => :monsieur
  end
end
