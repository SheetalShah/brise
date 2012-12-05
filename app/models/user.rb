class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invite_for => 2.weeks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type, :display_name, :street_address1, :street_address2, :city, :state, :zip_code, :country, :company_attributes
  attr_writer :signup_current_step, :show_ads_by

  # attr_accessible :title, :body
  before_save { |user| user.email = email.downcase }

  validates :display_name, presence: true, length: { maximum: 50 }
  validates_uniqueness_of :display_name
  validates :password, length: { minimum: 6 }, presence: true
   
 
  USER_TYPES = %w(individual company)
  validates_inclusion_of :user_type, :in => USER_TYPES

  has_one :company, :dependent => :destroy
  has_many :ads, :dependent => :destroy
  has_many :comments, :through => :ads 
  has_many :followed_users, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships
  
  has_many :relationship_ads, foreign_key: "follower_id", dependent: :destroy
  has_many :followedads, through: :relationship_ads
  has_many :reverse_relationship_ads, foreign_key: "followedad_id", class_name: "RelationshipAd", dependent: :destroy
  has_many :followers, through: :reverse_relationship_ads
  accepts_nested_attributes_for :company, :allow_destroy => true, :reject_if => proc { |attributes| attributes[ 'name' ].blank? }

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

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def followad!(ad)
    relationship_ads.create!(followedad_id: ad.id)
  end

  def unfollowad!(ad)
    relationship_ads.find_by_followedad_id(ad.id).destroy
  end

  def adfeed_by_type
    %w[followedusers followedads followedproducts]
  end

  def show_ads_by
    @show_ads_by || adfeed_by_type.first
  end

  def feed
    if(self.show_ads_by == "followedusers")
      @ads = Ad.from_users_followed_by(self)	
    else
      if(self.show_ads_by == "followedads")
        @ads = Ad.from_ads_followed_by(self)
      else
        @ads = Ad.all
      end
    end
  end
end
