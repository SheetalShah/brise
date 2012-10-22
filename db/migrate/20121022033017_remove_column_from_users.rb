class RemoveColumnFromUsers < ActiveRecord::Migration
  def up
	remove_column :users, :zip_code
  end

  def down
  end
end
