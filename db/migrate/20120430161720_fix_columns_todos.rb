class FixColumnsTodos < ActiveRecord::Migration
  def up
    rename_column :todos, :priority, :emergency
    rename_column :todos, :difficulty, :importance
  end

  def down
  end
end
