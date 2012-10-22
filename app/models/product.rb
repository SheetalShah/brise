class Product < ActiveRecord::Base
  attr_accessible :category, :description, :industry, :name, :product_type 
  has_many :reviews, :dependent => :destroy
  has_many :ads, :dependent => :nullify
  has_and_belongs_to_many :company
  validates_presence_of :product_type
  validates :description, :presence => true
  validates :industry, :presence => true
  validates_presence_of :category
  validates :name, length: { maximum: 60 }  
end
