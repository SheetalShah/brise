require 'money'
class Recreatecomemnts < ActiveRecord::Migration
  def change
	create_table :comments do |t|
	  t.text :description
	  t.integer :ad_id
	  t.money :indicative_price
	  t.string :indicative_options
	  t.boolean :match_price
	  t.timestamps
	end
	  
  end

  
  
end
