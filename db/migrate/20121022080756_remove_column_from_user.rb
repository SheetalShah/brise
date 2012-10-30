class RemoveColumnFromUser < ActiveRecord::Migration
  def up
	remove_column :users, :company
	remove_column :users, :individual
  end

  def down
	add_column :users, :represents_company, :boolean
	add_column :users, :represents_individual, :boolean
  end
end
