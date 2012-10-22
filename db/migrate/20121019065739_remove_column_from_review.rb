class RemoveColumnFromReview < ActiveRecord::Migration
  def up
	remove_column :reviews, :description
  end

  def down
  end
end
