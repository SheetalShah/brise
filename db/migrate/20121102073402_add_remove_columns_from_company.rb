class AddRemoveColumnsFromCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :street_address1
    remove_column :companies, :street_address2
    remove_column :companies, :city
    remove_column :companies, :state
    remove_column :companies, :country
    remove_column :companies, :zip_code
    remove_column :companies, :you_use
    remove_column :companies, :used_by

    add_column :companies, :rae_material_used_by, :text
    add_column :companies, :finished_product_uses, :text
    add_column :companies, :retails_in, :text

    add_column :users, :state, :string

  end
end
