class Comment < ActiveRecord::Base
  attr_accessible :description, :indicative_options, :indicative_price
  belongs_to :ad, :inverse_of => :comments, :touch => true
  validates_presence_of :ad
  validates_presence_of :description  
end
