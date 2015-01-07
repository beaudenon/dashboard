class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.integer :position
      t.string :color
      t.timestamps
    end
  end
end
