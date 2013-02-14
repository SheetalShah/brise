class CreateModelTable < ActiveRecord::Migration
  def up
	create_table :models do |t|
		t.string :name
		t.text :description
		t.timestamps
	end
  end

  def down
	drop_table :models
  end
end
