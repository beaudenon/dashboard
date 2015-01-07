class CreateWeddings < ActiveRecord::Migration
  def change
    create_table :weddings do |t|
      t.string :titre
      t.text :description
      t.string :lieu
      t.datetime :date
      t.integer :duree
      t.string :personne

      t.timestamps
    end
  end
end
