class Product < ActiveRecord::Base
  attr_accessible :category, :description, :industry, :name, :product_type , :model, :brands_attributes, :ads_attributes
  has_many :reviews, :dependent => :destroy
  has_many :ads, :dependent => :nullify, :class_name => 'Ad', :foreign_key => :product_id
  has_and_belongs_to_many :company
  has_many :brand_products, :foreign_key => :product_id
  has_many :brands, :through => :brand_products, :source => "brand", :dependent => :destroy

  has_many :relationship_products, foreign_key: "followedproduct_id", class_name: "RelationshipProduct", dependent: :destroy
  has_many :followers, through: :relationship_products

  accepts_nested_attributes_for :brands, :allow_destroy => true, :reject_if => proc { |attributes| attributes[ 'name' ].blank? }
  
  validates :name, length: { maximum: 60 }  

  letsrate_rateable "quality"


  def average_rating(rateable_obj, user=nil, dimension=nil)
    if( user != nil && dimension != nil )
      val = self.connection.select_value("select AVG(stars) from rates WHERE rater_id=#{user.id} and dimension='#{dimension}' and rateable_id=#{rateable_obj.id}");
    else
      if( user != nil )
        val = self.connection.select_value("select AVG(stars) from rates WHERE rater_id=#{user.id} and rateable_id=#{rateable_obj.id}");
      else
        val = self.connection.select_value("select AVG(stars) from rates WHERE rateable_id=#{rateable_obj.id}");	
      end
    end
   val
  end

end
