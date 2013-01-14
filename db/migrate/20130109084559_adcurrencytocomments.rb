class Adcurrencytocomments < ActiveRecord::Migration
  def change
	add_column :comments, :currency, :string
  end

  
  
end
