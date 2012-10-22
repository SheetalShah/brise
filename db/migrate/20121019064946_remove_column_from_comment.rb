class RemoveColumnFromComment < ActiveRecord::Migration
  def up
	remove_column :comments, :description
  end

  def down
	add_column :comments, :description, :text
  end
end
