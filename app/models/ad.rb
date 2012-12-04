class Ad < ActiveRecord::Base
  attr_accessible :ad_type, :details, :price_eval, :options_eval

  belongs_to :user
    def by_type
      user.user_type if user
    end
    def display_name
      user.display_name if user
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
  
  validates :user_id, presence: true
  has_many :comments, :inverse_of => :ad, :dependent => :destroy
  default_scope order: 'ads.created_at DESC'

  TYPES = %w(active inactive closed)
  validates :state, :inclusion => { :in => TYPES }

  AD_TYPE = %w(Buy Sell Rent)
  validates_inclusion_of :ad_type, :in => AD_TYPE
  
  validates :ad_type, presence: true
  validates :details, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

 TYPES.each do |state_name|
    define_method "#{state_name}?" do
	state == state_name
    end
  end
 
end

