class RemoveBrandnameModelnameFromProducts < ActiveRecord::Migration
  def up
	remove_column :products, :brandname
	remove_column :products, :modelname
	remove_column :ads, :productname
  end

  def down
	add_column :ads, :product_id, :integer
	add_column :ads, :brand_id, :integer
	add_column :ads, :model_id, :integer
  end
end
