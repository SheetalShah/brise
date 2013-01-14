class Admatchpricetocomments < ActiveRecord::Migration
  def change
	add_column :comments, :match_price, :boolean
  end

  
  
end
