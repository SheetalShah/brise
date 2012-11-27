class AddBrandProductInAds < ActiveRecord::Migration
  def up
  end

  def down
	add_column :ads, :brand_product, :integer
  end
end
