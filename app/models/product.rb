class Product < ActiveRecord::Base
  attr_accessible :category, :description, :industry, :name, :product_type , :model, :brands_attributes, :ads_attributes, :modeldescription
  has_many :ads, :dependent => :nullify, :class_name => 'Ad', :foreign_key => :product_id
  has_and_belongs_to_many :company
  has_many :brand_products, :foreign_key => :product_id
  has_many :brands, :through => :brand_products, :source => "brand", :dependent => :destroy

  has_many :relationship_products, foreign_key: "followedproduct_id", class_name: "RelationshipProduct", dependent: :destroy
  has_many :followers, through: :relationship_products
  accepts_nested_attributes_for :brands, :allow_destroy => true, :reject_if => proc { |attributes| attributes[ 'name' ].blank? }
  
  validates :name, length: { maximum: 60 }  
  validates_presence_of :name

  def self.findProduct(productname, modelname)
    connection.select_value("select * from products WHERE name='#{productname}' AND model='#{modelname}'");
  end

  def self.models_for_product(name)
    where("name='#{name}' AND model IS NOT NULL AND model <> ''")
  end
  
  def self.feed(user, type)
    case type
      when 'followedproducts'
        followed_product_ids = "SELECT followedproduct_id FROM relationship_products
                         WHERE follower_id = :user_id"
        where("id IN (#{followed_product_ids})", 
          user_id: user.id)
      else
        Product.all
    end
  end

end
