class Review < ActiveRecord::Base
  attr_accessible :description, :rating
  belongs_to :product
  validates_presence_of :description
  
end
