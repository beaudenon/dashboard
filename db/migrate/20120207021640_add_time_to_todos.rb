class AddTimeToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :minutes, :integer, :default => 0
  end
end
