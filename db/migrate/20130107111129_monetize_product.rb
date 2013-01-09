class MonetizeProduct < ActiveRecord::Migration
  def change
	add_column :ads, :price, :integer
	add_column :ads, :currency, :string
  end

end
