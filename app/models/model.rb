class Model < ProductComponent
  attr_accessible :ad_attributes, :products_attributes
  has_many :brand_products, :foreign_key => :model_id
  has_many :products, :through => :brand_products, :source => "product"
  has_many :brands, :through => :brand_products, :source => "brand"

  def treeViewLevels
    %w[product brand]
  end
end
