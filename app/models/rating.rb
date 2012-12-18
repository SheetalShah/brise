class Rating < ActiveRecord::Base
  attr_accessible :value
  belongs_to :product
  belongs_to :user
end
