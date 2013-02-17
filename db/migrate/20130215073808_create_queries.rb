class CreateQueries < ActiveRecord::Migration
  def up
    create_table :queries do |t|
      t.string :subject
      t.text :message
      t.datetime :sent_at
      t.string :to
      t.string :from
      t.timestamps
    end
  end

  def down
	drop_table :queries
  end
end
