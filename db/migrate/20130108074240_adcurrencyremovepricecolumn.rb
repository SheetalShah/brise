class Adcurrencyremovepricecolumn < ActiveRecord::Migration
  def change
	add_column :ads, :currency, :string
	
  end

  
  
end
