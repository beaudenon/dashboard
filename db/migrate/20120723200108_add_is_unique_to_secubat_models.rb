class AddIsUniqueToSecubatModels < ActiveRecord::Migration
  def change
    add_column :secubat_models, :is_unique, :boolean, :default => true
  end
end
