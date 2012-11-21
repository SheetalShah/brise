class ChangeAdType < ActiveRecord::Migration
  def up
	remove_column :ads, :eval_type
  end

  def down
	add_column :ads, :price_eval, :boolean
	add_column :ads, :options_eval, :boolean
	add_index :ads, [ :price_eval ]
	add_index :ads, [ :options_eval ]
  end
end
