class Ad < ActiveRecord::Base
  attr_accessible :ad_type, :details, :price_eval, :options_eval, :title 
  has_and_belongs_to_many :product
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  TYPES = %w(active inactive closed)
  validates :state, :inclusion => { :in => TYPES }

  AD_TYPE = %w(Buy Sell Rent)
  validates_inclusion_of :ad_type, :in => AD_TYPE

  validates_presence_of :ad_type
  validates :details, presence: true, length: { maximum: 250 }

 TYPES.each do |state_name|
    define_method "#{state_name}?" do
	state == state_name
    end
  end
 
end

