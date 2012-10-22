class Product < ActiveRecord::Base
  attr_accessible :category, :description, :finished_product, :industry, :name, :raw_material
  has_many :reviews, :dependent => :destroy
  has_many :ads, :dependent => :nullify
  has_and_belongs_to_many :company
end
