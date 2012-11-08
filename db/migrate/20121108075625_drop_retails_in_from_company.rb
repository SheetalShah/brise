class DropRetailsInFromCompany < ActiveRecord::Migration
  def up
	remove_column :companies, :retails_in
  end

  def down
  end
end
