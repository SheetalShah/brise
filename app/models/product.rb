class Product < ProductComponent
  attr_accessible :category, :industry, :product_type, :brands_attributes, :ads_attributes
  has_many :ads, :dependent => :nullify, :class_name => 'Ad', :foreign_key => :product_id
  has_many :brand_products, :foreign_key => :product_id
  has_many :brands, :through => :brand_products, :source => "brand", :dependent => :destroy
  has_many :models, :through => :brand_products, :source => "model"

  has_many :company_manufactured_products, foreign_key: "product_id" #, class_name: "ManufacturedProduct"
  has_many :manufacturing_companies, through: :company_manufactured_products, source: :company

  has_many :company_retail_products, foreign_key: "product_id" #, class_name: "RetailProduct"
  has_many :retail_companies, through: :company_retail_products, source: :company

  accepts_nested_attributes_for :company_manufactured_products, :allow_destroy => true
  accepts_nested_attributes_for :company_retail_products, :allow_destroy => true

  has_many :relationship_products, foreign_key: "followedproduct_id", class_name: "RelationshipProduct", dependent: :destroy
  has_many :followers, through: :relationship_products
  accepts_nested_attributes_for :brands, :allow_destroy => true, :reject_if => proc { |attributes| attributes[ 'name' ].blank? }
  
  def brand_products_for_product
    BrandProduct.where("product_id IN (SELECT p.id FROM products p WHERE p.name = '#{name}' )")
  end 

  def ads
    Ad.product_ads(self.name, '')
  end

  def treeViewLevels
    %w[brand model]
  end

  def userfeed(show_users_by)
    case show_users_by
      when 'manufacturers'
        self.manufacturing_companies
      when 'retailers'
        self.retail_companies
      else
        User.all
    end
  end

  def adfeed(show_ads_by)
    Ad.product_ads(self.name, '')
  end
end
