class CreateSecubatModels < ActiveRecord::Migration
  def change
    create_table :secubat_models do |t|
      t.string :subject
      t.string :body
      t.string :filename
      t.text :description
      t.timestamps
    end
  end
end
