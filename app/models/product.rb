class Product < ActiveRecord::Base
  attr_accessible :category, :description, :industry, :name, :product_type , :model, :brands_attributes, :ads_attributes
  has_many :reviews, :dependent => :destroy
  has_many :ads, :dependent => :nullify, :class_name => 'Ad', :foreign_key => :product_id
  has_and_belongs_to_many :company
  has_many :brand_products, :foreign_key => :product_id
  has_many :brands, :through => :brand_products, :source => "brand", :dependent => :destroy
  accepts_nested_attributes_for :brands, :allow_destroy => true, :reject_if => proc { |attributes| attributes[ 'name' ].blank? }
  
  validates :name, length: { maximum: 60 }  
end
