class AddColumnsToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :position, :int
    add_column :statuses, :color, :string
    add_column :statuses, :progress, :decimal, :default=>0.0, :null=>false, :precision=>5, :scale=>2
  end
end
