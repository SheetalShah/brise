class DropTableBrandsProducts < ActiveRecord::Migration
  def up
	drop_table :brands_products
  end

  def down
	
  end
end
