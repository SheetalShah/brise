class AddCompanyIndividualToUsers < ActiveRecord::Migration
  def change
	add_column :users, :individual, :boolean
	add_column :users, :company, :boolean
  end
end
