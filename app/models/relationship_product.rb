class RelationshipProduct < ActiveRecord::Base
  attr_accessible :followedproduct_id 

  belongs_to :follower, class_name: "User"
  belongs_to :followedproduct, class_name: "Product"

  validates :follower_id, presence: true
  validates :followedproduct_id, presence: true
end
