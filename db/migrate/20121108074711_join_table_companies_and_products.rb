class JoinTableCompaniesAndProducts < ActiveRecord::Migration
  def change
	create_table :companies_products do |t|
	  t.integer :company_id, :null => false
	  t.integer :product_id, :null => false
        end
  end

  
  end
