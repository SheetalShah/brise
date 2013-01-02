class DeleteIndexFromRate < ActiveRecord::Migration
  def up
	remove_index "rates", "rater_id"
  end

  def down
  end
end
