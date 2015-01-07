class AddDeadlineToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :deadline_at, :datetime
  end
end

