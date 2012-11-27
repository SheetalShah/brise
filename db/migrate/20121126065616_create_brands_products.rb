class CreateBrandsProducts < ActiveRecord::Migration
  def change
    create_table :brands_products do |t|
      t.integer :brand_id
      t.integer :product_id

      t.timestamps
    end
  end
end
