class RemoveColumnFromProduct < ActiveRecord::Migration
  def up
	remove_column :products, :description
  end

  def down
  end
end
