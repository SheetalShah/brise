class CreateCompanyManufacturedProducts < ActiveRecord::Migration
  def change
    create_table :company_manufactured_products do |t|
      t.integer :product_id
      t.integer :company_id

      t.timestamps
    end
  end
end
