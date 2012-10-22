class Ad < ActiveRecord::Base
  attr_accessible :buy, :details, :options_eval, :price_eval, :rent, :sell
  belongs_to :product
  belongs_to :user
  has_many :comments
  
  TYPES = %w(active inactive closed)
  validates :state, :inclusion => { :in => TYPES }
  
end
