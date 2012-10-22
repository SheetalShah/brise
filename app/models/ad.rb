class Ad < ActiveRecord::Base
  attr_accessible :ad_type, :details, :eval_type 
  belongs_to :product
  belongs_to :user
  has_many :comments, :dependent => :destroy

  
  TYPES = %w(active inactive closed)
  validates :state, :inclusion => { :in => TYPES }

  AD_TYPE = %w(buy sell rent)
  validates_inclusion_of :ad_type, :in => :AD_TYPE

  EVAL_TYPES = %w(price eval)
  validates_inclusion_of :eval_type, :in => EVAL_TYPES

  validates_presence_of :ad_type
  validates_presence_of :eval_type	  
  validates :details, presence: true, length: { maximum: 250 }
end
