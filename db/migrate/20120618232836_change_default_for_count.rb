class ChangeDefaultForCount < ActiveRecord::Migration
  def up
    change_column :sites, :count, :integer, :default => 0, :null => false 
  end

  def down
  end
end
