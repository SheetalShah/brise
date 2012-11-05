class RenameUserIdToCompany < ActiveRecord::Migration
  def change
	remove_column :companies, :user_if
	add_column :companies, :user_id, :integer
  end
end
