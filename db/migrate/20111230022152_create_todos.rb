class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.references :project
      t.string :title, :limit => 1024
      t.string :url
      t.text :description
      t.date :datetime
      t.references :status
      t.timestamps
    end
  end
end
