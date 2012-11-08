class DropHelpsTable < ActiveRecord::Migration
  def change
  	drop_table :helps 
	drop_table :company_products
	drop_table :companies_products
  end
end
