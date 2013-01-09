class AddModelDescription < ActiveRecord::Migration
  def change
	add_column :products, :modeldescription, :text
  end

  
  
end
