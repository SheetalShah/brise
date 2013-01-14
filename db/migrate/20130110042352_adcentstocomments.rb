class Adcentstocomments < ActiveRecord::Migration
  def change	
	add_column :comments, :indicative_price_cents, :integer
	add_column :comments, :indicative_price_currency, :string
  end

  
  
end
