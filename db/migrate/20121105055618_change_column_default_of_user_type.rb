class ChangeColumnDefaultOfUserType < ActiveRecord::Migration
  def change
	change_column_default :users, :user_type, "individual"
  end

end
