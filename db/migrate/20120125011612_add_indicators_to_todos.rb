class AddIndicatorsToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :difficulty, :integer, :default => 1
    add_column :todos, :priority, :integer, :default => 1
  end
end
