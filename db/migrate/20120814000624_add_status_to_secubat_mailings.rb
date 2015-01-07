class AddStatusToSecubatMailings < ActiveRecord::Migration
  def change
    add_column :secubat_mailings, :status, :string, :default => :pending
  end
end
