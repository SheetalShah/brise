class AddZipCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zip_code, :integer
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :street_address1, :string
    add_column :users, :street_address2, :string
	
  end
end
