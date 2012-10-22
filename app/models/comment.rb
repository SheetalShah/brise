class Comment < ActiveRecord::Base
  attr_accessible :description, :indicative_options, :indicative_price
  belongs_to :ad, :touch => true

  validates_presence_of :description  
end
