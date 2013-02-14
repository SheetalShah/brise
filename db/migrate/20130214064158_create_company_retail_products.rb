class CreateCompanyRetailProducts < ActiveRecord::Migration
  def change
    create_table :company_retail_products do |t|
      t.integer :product_id
      t.integer :company_id

      t.timestamps
    end
  end
end
