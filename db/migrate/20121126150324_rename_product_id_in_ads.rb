class RenameProductIdInAds < ActiveRecord::Migration
  def up
	rename_column :ads, :product_id, :brand_product_id
	remove_column :ads, :brand_id
  end

  def down
  end
end
