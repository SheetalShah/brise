class BrandProduct < ActiveRecord::Base
  attr_accessible :brand_id, :product_id
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
end
