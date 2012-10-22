class RelationshipAd < ActiveRecord::Base
  attr_accessible :followedad_id 

  belongs_to :follower, class_name: "User"
  belongs_to :followedad, class_name: "Ad"

  validates :follower_id, presence: true
  validates :followedad_id, presence: true
end
