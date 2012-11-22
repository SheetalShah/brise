class RenameProductToProductname < ActiveRecord::Migration
  def up
	rename_column :ads, :product, :productname
  end

  def down
  end
end
