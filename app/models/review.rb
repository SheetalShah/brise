class Review < ActiveRecord::Base
  attr_accessible :description
  belongs_to :product
end
