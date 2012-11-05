class ChangeColumnNameToCompanyName < ActiveRecord::Migration
  def change
	remove_column :companies, :name
	add_column :companies, :company_name, :string
  end

  
  
end
