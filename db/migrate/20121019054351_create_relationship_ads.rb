class CreateRelationshipAds < ActiveRecord::Migration
  def change
    create_table :relationship_ads do |t|
      t.integer :follower_id
      t.integer :followedad_id

      t.timestamps
    end

    add_index :relationship_ads, :follower_id
    add_index :relationship_ads, :followedad_id
    add_index :relationship_ads, [:follower_id, :followedad_id], unique: true
  end
end
