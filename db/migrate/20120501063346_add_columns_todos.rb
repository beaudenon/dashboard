class AddColumnsTodos < ActiveRecord::Migration
  def up
    add_column :todos, :past_time, :integer, :default => 0
    add_column :todos, :finished_at, :datetime
    add_column  :todos, :position, :integer, :default => 1
    add_column :todos, :difficulty, :integer, :default => 1
    add_column :todos, :timer, :integer, :default => 0
    add_column :todos, :archived_at, :datetime
    rename_column :todos, :minutes, :estimated_time
    rename_column :todos, :date, :to_begin_at
  end

  def down
  end
end
