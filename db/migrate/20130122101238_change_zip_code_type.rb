class ChangeZipCodeType < ActiveRecord::Migration
  def up
	change_column :users, :zip_code, :string
  end

  def down
  end
end
