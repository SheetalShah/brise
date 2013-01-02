class AddBrandProductIdToReviews < ActiveRecord::Migration
  def change
	remove_column :reviews, :product_id
	add_column :reviews, :brand_product_id, :integer
  end
end
