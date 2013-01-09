require 'letsrate'
module BrandProductsHelper
  def rating_for_override(rateable_obj, dimension=nil, options={})
    user = options[:user] || nil
    avg = rateable_obj.average_rating(rateable_obj, user, dimension)
  
    star = options[:star] || 5
    readonly = options[:readonly] || false
    
    content_tag :div, "", "data-dimension" => dimension, :class => 'star', "data-rating" => avg, "name" => "rating",
                          "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
                          "data-star-count" => star, "data-readOnly" => readonly
    
    
  end
end
