class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User", :dependent => :destroy
  belongs_to :rateable, :polymorphic => true, :dependent => :destroy
  
  attr_accessible :rate, :dimension
  
end
