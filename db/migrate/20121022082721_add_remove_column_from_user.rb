class AddRemoveColumnFromUser < ActiveRecord::Migration
  def change
	remove_column :users, :represents_individual
	remove_column :users, :represents_company
	add_column :users, :user_type, :string
  end
end
