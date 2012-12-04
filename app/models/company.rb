class Company < ActiveRecord::Base
  attr_accessible :city, :manufacturer, :finished_product_manufacturer, :retailer, :country, :company_name, :company_type, :state, :street_address1, :street_address2, :manufacturer_products_attributes, :retailer_products_attributes

  has_and_belongs_to_many :manufacturer_products, :class_name => "Product"
  has_and_belongs_to_many :retailer_products, :class_name => "Product"
  has_many :brands
  
  accepts_nested_attributes_for :manufacturer_products, :allow_destroy => true
  accepts_nested_attributes_for :retailer_products, :allow_destroy => true
  #validates  :company_name, :presence => true
  belongs_to :user, foreign_key => :user_id

end
