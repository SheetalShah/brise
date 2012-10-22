class Company < ActiveRecord::Base
  attr_accessible :city, :country, :name, :private, :public, :state, :street_address1, :street_address2
  has_and_belongs_to_many :products

end
