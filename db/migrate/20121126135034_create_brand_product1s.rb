class CreateBrandProduct1s < ActiveRecord::Migration
  def change
    create_table :brand_products do |t|
      t.integer :brand_id
      t.integer :product_id

      t.timestamps
    end
  end
end
