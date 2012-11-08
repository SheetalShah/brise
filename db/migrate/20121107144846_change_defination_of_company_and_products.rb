class ChangeDefinationOfCompanyAndProducts < ActiveRecord::Migration
  def change
	remove_column :companies, :finished_product_uses
	remove_column :companies, :raw_material_used_by
	remove_column :companies, :raw_material_manufacturer
	remove_column :companies, :finished_product_manufacturer
	add_column :companies, :manufacturer, :boolean
  end
   
end
