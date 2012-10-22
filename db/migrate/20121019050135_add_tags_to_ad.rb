class AddTagsToAd < ActiveRecord::Migration
  def change
	add_column :ads, :tags, :string
	add_index :ads, :tags 
  end
end
