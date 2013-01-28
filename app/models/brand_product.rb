class BrandProduct < ActiveRecord::Base
  attr_accessible :brand_id, :product_id
  has_many :reviews
  letsrate_rateable "quality"
  belongs_to :brand
    def brand_name
      if brand
        brand.name 
      else
        ""
      end 
    end
  belongs_to :product
    def product_name
      if product
        product.name 
      else
        ""
      end
    end
    def model_name
      if product
        product.model 
      else
        ""
      end
    end
  has_many :ads, :foreign_key => :brand_product_id 

  def brand_product
    brand_name + " " + model_name + " " + product_name
  end

  def self.search(product, brand)
    product = Product.find_by_name_and_model(product.name, product.model)
    brand   = Brand.find_by_name(brand.name) unless brand.name.empty?
    brand_product = BrandProduct.find_by_brand_id_and_product_id(brand, product) || BrandProduct.new
    brand_product.product = product || brand_product.build_product(product) if !brand_product
    brand_product.brand = brand || brand_product.build_brand(brand) if !brand_product
    brand_product
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
