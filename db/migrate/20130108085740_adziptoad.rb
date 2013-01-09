class Adziptoad < ActiveRecord::Migration
  def change
	add_column :ads, :ad_zip_code, :integer
	add_column :ads, :use_address_zip_code, :boolean
  end

  def down
  end
end
