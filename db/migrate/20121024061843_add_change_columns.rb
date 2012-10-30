class AddChangeColumns < ActiveRecord::Migration
  def up
	remove_column :companies, :deals_with_product_type
  end

  def down
	add_column :ads, :title, :string
	add_column :companies, :raw_material_manufacturer, :boolean
	add_column :companies, :finished_product_manufacturer, :boolean
	add_column :companies, :retailer, :boolean
  end
end
