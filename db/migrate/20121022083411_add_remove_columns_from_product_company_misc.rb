class AddRemoveColumnsFromProductCompanyMisc < ActiveRecord::Migration
  def change
	remove_column :ads, :buy
	remove_column :ads, :sell
	remove_column :ads, :rent
	remove_column :ads, :price_eval
	remove_column :ads, :options_eval
	remove_column :companies, :private
	remove_column :companies, :public
	remove_column :companies, :raw_material_manufacturer
	remove_column :companies, :finished_product_manufacturer
	remove_column :companies, :retailer
	remove_column :products, :raw_material
	remove_column :products, :finished_product


	add_column :ads, :ad_type, :string
	add_column :ads, :eval_type, :string
	add_column :companies, :company_type, :string
	add_column :companies, :deals_with_product_type, :string
	add_column :products, :product_type, :string
  end
end
