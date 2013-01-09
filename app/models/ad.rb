class Ad < ActiveRecord::Base
  attr_accessible :ad_type, :details, :price_eval, :options_eval, :price_cents, :currency, :use_address_zip_code, :ad_zip_code, :state
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

  def self.from_ads_followed_by(user)
    followed_ad_ids = "SELECT followedad_id FROM relationship_ads
                         WHERE follower_id = :user_id"
    where("id IN (#{followed_ad_ids}) OR user_id = :user_id", 
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

  def userfollowing(user)
    relationship_ads.create!(follower_id: user.id)
  end

 TYPES.each do |state_name|
    define_method "#{state_name}?" do
	state == state_name
    end
  end
 
end

