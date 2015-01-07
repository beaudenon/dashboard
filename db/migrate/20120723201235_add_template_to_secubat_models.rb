class AddTemplateToSecubatModels < ActiveRecord::Migration
  def change
    add_column :secubat_models, :template, :string, :default => nil
  end
end
