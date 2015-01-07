class AddIsAdminToSecubatClients < ActiveRecord::Migration
  def change
    add_column :secubat_clients, :is_admin, :boolean, :default => false
  end
end
