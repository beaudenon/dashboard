class AddMailingVoeuxToSecubatClient < ActiveRecord::Migration
  def change
    add_column :secubat_clients, :mailing_voeux, :boolean
  end
end
