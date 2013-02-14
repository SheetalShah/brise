class CompanyManufacturedProduct < ActiveRecord::Base
  attr_accessible :company_id, :product_id

  belongs_to :company, class_name: :User
  belongs_to :product
end
