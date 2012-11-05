class AddUserIdToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :user_if, :integer
  end
end
