class DropRatingTableAnd < ActiveRecord::Migration
  def up
	remove_column :reviews, :rating
	drop_table :ratings

  end

  def down
  end
end
