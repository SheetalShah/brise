class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  acts_as_taggable
  acts_as_tagger
  devise :invitable, :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invite_for => 2.weeks

#  skip_filter :verify_authenticity_token  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type, :display_name, :city, :state, :zip_code, :country, :company_attributes, 
  :avatar, :description, :tag_list
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/guest.png"
  attr_writer :signup_current_step, :show_ads_by, :show_users_by

  # attr_accessible :title, :body
  before_save { |user| user.email = email.downcase }

  validates :display_name, presence: true, length: { maximum: 50 }
#  validates_uniqueness_of :display_name
  validates :password, length: { minimum: 6 }, presence: true
   
 
  USER_TYPES = %w(individual company)
  validates_inclusion_of :user_type, :in => USER_TYPES

#  has_one :company, :dependent => :destroy
  has_many :ads, :dependent => :destroy
  has_many :comments
  has_many :followed_users, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships
  
  has_many :relationship_ads, foreign_key: "follower_id", dependent: :destroy
  has_many :followedads, through: :relationship_ads
  has_many :reviews

  has_many :relationship_products, foreign_key: "follower_id", dependent: :destroy
  has_many :followedproducts, through: :relationship_products

  has_many :company_retail_products, foreign_key: "company_id"
  has_many :retail_products, through: :company_retail_products, source: :product

  has_many :company_manufactured_products, foreign_key: "company_id"
  has_many :manufactured_products, through: :company_manufactured_products, source: :product

  accepts_nested_attributes_for :company_manufactured_products, :allow_destroy => true
  accepts_nested_attributes_for :company_retail_products, :allow_destroy => true
  letsrate_rater
  acts_as_gmappable validation: false
#  accepts_nested_attributes_for :company, :allow_destroy => true, :reject_if => proc { |attributes| attributes[ 'name' ].blank? }

  def gmaps4rails_address
    "#{self.city} #{self.zip_code}, #{self.country}" 
  end

  def signup_current_step
    @signup_current_step || signup_steps.first
  end

  def signup_steps
    %w[basicinfo additionalinfo]
  end

  def signup_next_step
    self.signup_current_step = signup_steps[signup_steps.index(signup_current_step)+1]
  end

  def signup_previous_step
    self.signup_current_step = signup_steps[signup_steps.index(signup_current_step)-1]
  end

  def signup_first_step?
    signup_current_step == signup_steps.first
  end

  def signup_last_step?
    signup_current_step == signup_steps.last
  end

  def signup_all_valid?
    signup_steps.all? do |signup_step|
      self.signup_current_step = signup_step
      valid?
    end
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def following_ad?(ad)
    relationship_ads.find_by_followedad_id(ad.id)
  end

  def following_product?(product)
    relationship_products.find_by_followedproduct_id(product.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def followadbuild(ad)
    relationship_ads.build(followedad_id: ad.id)	
  end

  def followad!(ad)
    relationship_ads.create!(followedad_id: ad.id)
  end

  def unfollowad!(ad)
    relationship_ads.find_by_followedad_id(ad.id).destroy
  end

  def followproduct!(product)
    relationship_products.create!(followedproduct_id: product.id)
  end

  def unfollowproduct!(product)
    relationship_products.find_by_followedproduct_id(product.id).destroy
  end 

  def adfeed_by_type
    %w[all followedusers followedads followedproducts]
  end

  def show_ads_by
    @show_ads_by || adfeed_by_type.first
  end

  def show_users_by
    @show_users_by || "all"
  end

  def self.comments_user(ad)
    comments_user_ids = "SELECT user_id FROM comments
                         WHERE ad_id = :ad_id"
    where("id IN (#{comments_user_ids})", ad_id: ad.id)
  end


  def self.search_query( param )
    "display_name LIKE '%#{param}%' OR description LIKE '%#{param}%'"
  end

  def userfeed(show_users_by)
    case show_users_by
      when 'following'
        self.followed_users
      when 'followers'
        self.followers
      else
        User.all
    end
  end

  def productfeed(show_products_by)
    case show_products_by
      when 'followedproducts'
        self.followedproducts
      when 'manufacturedproducts'
        self.manufactured_products
      when 'retailproducts'
        self.retail_products
      else
        Product.all
    end
  end

  def adfeed(show_ads_by)
    case show_ads_by
      when 'followedusers'
        @ads = Ad.from_users_followed_by(self)	
      when 'followedads'
        @ads = self.followedads
      when 'followedproducts'
        @ads = Ad.from_adproducts_followed_by(self)
      when 'myads'
        @ads = self.ads
      when 'myquoted'
        @ads = Ad.my_quoted_ads(self)
      else
        @ads = Ad.all
    end
  end
end
