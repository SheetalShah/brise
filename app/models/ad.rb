class Ad < ActiveRecord::Base
  attr_accessible :ad_type, :details, :price_eval, :options_eval, :price_cents, :currency, :use_address_zip_code, :ad_zip_code, :state, :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/guest.png"
  belongs_to :user
    def by_type
      user.user_type if user
    end
    def display_name
      user.display_name if user
    end
    def correct_user
      current_user?(user) if user
    end
  belongs_to :brand_product, :foreign_key => :brand_product_id
    def product_name
      brand_product.product_name if brand_product
    end
    def model_name
      brand_product.model_name if brand_product
    end
    def brand_name
      brand_product.brand_name if brand_product
    end

  monetize :price_cents
#  after_create :check_product_entry
  
  validates :user_id, presence: true
  has_many :comments, :inverse_of => :ad, :dependent => :destroy
  has_many :relationship_ads, foreign_key: "followedad_id", class_name: "RelationshipAd", dependent: :destroy
  has_many :followers, through: :relationship_ads
  default_scope order: 'ads.created_at DESC'

  TYPES = %w(active inactive closed)
  validates :state, :inclusion => { :in => TYPES }

  AD_TYPE = %w(Buy Sell Rent)
  validates_inclusion_of :ad_type, :in => AD_TYPE
  
  validates :ad_type, presence: true
  validates :details, presence: true

  def opp_price_type
    case self.ad_type
      when 'Buy'
        'Ask'
      when 'Sell'
        'Bid'
      else
        'N/A'
    end
  end

  def ad_name
    parts = []
    if brand_name.present?
      parts << brand_name
    end
    if model_name.present?
      parts << model_name
    end
    parts << product_name
    parts.join(" | ")
  end

  def pre_ad_name
    parts = []
    if brand_name.present?
      parts << brand_name
    end
    if model_name.present?
      parts << model_name
    end
    parts.join(" | ")
  end

  def self.from_ads_followed_by(user)
    followed_ad_ids = "SELECT followedad_id FROM relationship_ads
                         WHERE follower_id = :user_id"
    where("id IN (#{followed_ad_ids})", 
          user_id: user.id)
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def self.from_adproducts_followed_by(user)
    followed_product_ids = "SELECT followedproduct_id FROM relationship_products
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_product_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def self.my_quoted_ads(user)
    ad_ids = "SELECT ad_id FROM comments c
                         WHERE c.user_id = #{user.id}"
    connection.select_values("select id from ads WHERE id IN (#{ad_ids}) AND user_id <>  #{user.id}")
  end

  def self.my_created_ads(user)
    ad_ids = "SELECT id FROM ads
                         WHERE user_id = :user_id"
    where("id IN (#{ad_ids})", 
          user_id: user.id)
  end

  def userfollowing(user)
    relationship_ads.create!(follower_id: user.id)
  end

  def indicative_prices
    self.comments
  end

  def self.ads_group
    Ad.find(:all).group_by &:brand_product_id
  end

  def self.brand_product_collection_name(ads)
    names = []
    ads.each do |ad|
      names << ad.ad_name unless names.include?(ad.ad_name)
    end
    names.join(', ')
  end

  def best_price
    case ad_type
      when 'Buy'
        self.connection.select_value( "SELECT MIN(indicative_price_cents) FROM comments
                           WHERE ad_id = #{self.id}" )
      when 'Sell'
        self.connection.select_value( "SELECT MAX(indicative_price_cents) FROM comments
                           WHERE ad_id = #{self.id}" )
      else
        'N/A'
    end
  end

  def self.product_ads(productname, ad_type = '', ad_id = nil)
    # find relevant products from Products table
    brand_product_ids = "SELECT c.id FROM brand_products c
                         WHERE c.product_id IN (SELECT p.id FROM products p WHERE p.name= '#{productname}' )"

    
    query = "brand_product_id IN (#{brand_product_ids})"
    if( ad_type.present? )
      query = query + " AND ad_type = '#{ad_type}'"
    end
    if( ad_id.present? )
      query = query + " AND id <> #{ad_id}"
    end
    Ad.where(query, ad_type: ad_type)
  end

  def ads_of_type(type)
    # find the product of the ad
    product_id = BrandProduct.find( brand_product_id ).product_id
    product    = Product.find(product_id)
    productname = product.name
    case type
      when 'relevant'
        if ad_type == 'Buy'
	  ad_type_to_use = 'Sell'
        else
          ad_type_to_use = 'Buy'
        end
      when 'similar'
        ad_type_to_use = ad_type
	ad_id_to_ignore = id
      else
           ad_type_to_use = ""
    end
    Ad.product_ads(productname, ad_type_to_use, ad_id_to_ignore)
  end

  def user_price(user)
    self.connection.select_value( "SELECT indicative_price_cents FROM comments
                         WHERE ad_id = #{self.id} and user_id= #{user.id}" )
  end

  def self.search_query( param )
    brand_product_ids = "SELECT c.id FROM brand_products c
                         WHERE c.product_id IN (SELECT p.id FROM products p WHERE p.name LIKE '%#{param}%' OR p.model LIKE '%#{param}%' ) OR
			       c.brand_id IN (SELECT b.id FROM brands b WHERE b.name LIKE '%#{param}%' )"
    "details LIKE '%#{param}%' OR brand_product_id IN (#{brand_product_ids})"
  end

 TYPES.each do |state_name|
    define_method "#{state_name}?" do
	state == state_name
    end
  end
 
end

