class Review < ActiveRecord::Base
  attr_accessible :description
  belongs_to :brand_product, :dependent => :destroy
  belongs_to :user
    def display_name
      user.display_name if user
    end
  validates_presence_of :description
  
end
