class Comment < ActiveRecord::Base
  attr_accessible :description, :indicative_options, :indicative_price
  belongs_to :ad
  
end
