class CreateRelationshipproducts < ActiveRecord::Migration
  def change
	create_table :relationship_products do |t|
	  t.integer :follower_id
	  t.integer :followedproduct_id
	  t.timestamps
	end
	add_index :relationship_products, :follower_id
	add_index :relationship_products, :followedproduct_id
	add_index :relationship_products, [:follower_id, :followedproduct_id], unique:true, name: "index_relationshipproducts_follower_followedprodict_id"
  end

 
end
