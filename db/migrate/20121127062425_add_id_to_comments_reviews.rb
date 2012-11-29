class AddIdToCommentsReviews < ActiveRecord::Migration
  def change
	add_column :comments, :ad_id, :integer
	add_column :reviews, :product_id, :integer
  end
end
