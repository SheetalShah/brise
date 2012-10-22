class Company < ActiveRecord::Base
  attr_accessible :city, :country, :name, :company_type, :state, :street_address1, :street_address2
  has_and_belongs_to_many :products

  validates_presence_of :city
  validates_presence_of :country
  validates  :name, :presence => true
  validates_presence_of :state
  validates_presence_of :street_address1

end
