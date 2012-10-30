class AddConfirmableToDeviseV1 < ActiveRecord::Migration
  def change
	add_column :users, :confirmed_at, :time
	add_column :users, :confirmation_token, :string
	add_column :users, :confirmation_sent_at, :time
	add_column :users, :unconfirmed_email, :string
	add_index :users, :confirmation_token, :unique => true
  end
end
