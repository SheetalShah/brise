class AdModelIdToBrandProduct < ActiveRecord::Migration
  def up
	add_column :brand_products, :model_id, :integer
  end

  def down
	delete_column :brand_products, :model_id
  end
end
