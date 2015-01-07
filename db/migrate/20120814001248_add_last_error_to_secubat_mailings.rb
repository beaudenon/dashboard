class AddLastErrorToSecubatMailings < ActiveRecord::Migration
  def change
    add_column :secubat_mailings, :last_error, :text
  end
end
