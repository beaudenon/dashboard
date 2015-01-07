class AddTypeIdToTodos < ActiveRecord::Migration
  def change
    change_table :todos do |t|
      t.references :type
    end
  end
end
