class AddCompanyTypeToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :raw_material_manufacturer, :boolean
    add_column :companies, :finished_product_manufacturer, :boolean
    add_column :companies, :retailer, :boolean
    add_column :companies, :used_by, :text
    add_column :companies, :you_use, :text

    add_index :companies, :raw_material_manufacturer
    add_index :companies, :finished_product_manufacturer
    add_index :companies, :retailer
    
  end
end
