class ChangeDefaultValueOfAdState < ActiveRecord::Migration
  def up
	change_column :ads, :state, :string, :default => 'active', :null => false
  end

  def down
  end
end
