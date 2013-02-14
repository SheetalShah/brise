class ProductComponent < ActiveRecord::Base
  self.abstract_class = true
  attr_accessible :description, :name
  validates :name, length: { maximum: 60 }  
  validates_presence_of :name
  attr_writer :treeView_current_level

  def treeView_level_reset
    self.treeView_current_level = treeViewLevels.first
  end

  def treeView_current_level
    @treeView_current_level || treeViewLevels.first
  end

  def treeView_next_level
    self.treeView_current_level = treeViewLevels[treeViewLevels.index(treeView_current_level)+1]
  end

  def treeView_first_level?
    treeView_current_level == treeViewLevels.first
  end

  def treeView_last_level?
    treeView_current_level == treeViewLevels.last
  end

  def has_any_treeView_objects_for(arr)
    parts = []
    arr.each do |obj|
      parts << "#{obj.class}_id = #{obj.id}"
    end
    query = "(SELECT b.#{treeView_current_level}_id FROM brand_products b
                          WHERE #{parts.join(' AND ')})"

     
    treeView_current_level.classify.constantize.where( "id IN #{query}" )
  end
end

