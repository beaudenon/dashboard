class AddIsActivatedToSecubatModels < ActiveRecord::Migration
  def change
    add_column :secubat_models, :is_activated, :boolean, :default => false
  end
end
