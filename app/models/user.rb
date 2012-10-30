class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invite_for => 2.weeks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type, :display_name
  # attr_accessible :title, :body
  before_save { |user| user.email = email.downcase }

  validates :display_name, presence: true, length: { maximum: 50 }
  validates :user_type, presence: true
  validates :password, length: { minimum: 6 }
 
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
end
