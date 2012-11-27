class CreateBrandProducts < ActiveRecord::Migration
  def change
    create_table :brands_products do |t|
      t.integer :brand_id, :null => false
      t.integer :product_id, :null => false
    end
  end
end
