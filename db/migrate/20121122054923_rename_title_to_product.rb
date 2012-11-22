class RenameTitleToProduct < ActiveRecord::Migration
  def up
	remove_column :ads, :title
  end

  def down
	add_column :ads, :product, :string
  end
end
