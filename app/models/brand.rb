
class Brand < ProductComponent
  attr_accessible :ad_attributes, :products_attributes
#  has_and_belongs_to_many :product
  has_many :brand_products, :foreign_key => :brand_id
  has_many :products, :through => :brand_products, :source => "product"
  has_many :models, :through => :brand_products, :source => "model"
  accepts_nested_attributes_for :products, :allow_destroy => true, :reject_if => proc { |attributes| attributes[ 'name' ].blank? }
  belongs_to :company
  has_many :ads, :dependent => :nullify, :class_name => 'Ad', :foreign_key => :brand_id

  def self.findBrand(brand)
    connection.select_value("select * from brands WHERE name='#{brand}'");
  end

  def treeViewLevels
    %w[product model]
  end
end
