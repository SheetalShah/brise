class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :indicative_price
      t.string :indicative_options

      t.timestamps
    end
  end
end
