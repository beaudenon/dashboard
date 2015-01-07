class AddProgressToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :progress, :decimal, :default=>0.0, :null=>false, :precision=>5, :scale=>2
  end
end
