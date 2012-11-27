class AddBrandnameModelnameToProducts < ActiveRecord::Migration
  def change
	add_column :products, :brandname, :string
	add_column :products, :modelname, :string
  end
end
