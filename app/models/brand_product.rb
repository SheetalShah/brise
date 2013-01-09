class BrandProduct < ActiveRecord::Base
  attr_accessible :brand_id, :product_id
  has_many :reviews
  letsrate_rateable "quality"
  belongs_to :brand
    def brand_name
      brand.name if brand
    end
  belongs_to :product
    def product_name
      product.name if product
    end
    def model_name
      product.model if product
    end
  has_many :ads, :foreign_key => :brand_product_id 

  def self.findBrandProduct(product, brand)
    where("product_id=#{product.id} AND brand_id=#{brand.id}");
  end

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
