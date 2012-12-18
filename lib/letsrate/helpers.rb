module Helpers
  def rating_for_now(rateable_obj, dimension=nil, options={})
 
    if dimension.nil?
      klass = rateable_obj.average
    else
      klass = rateable_obj.average "#{dimension}"
    end
    
    if klass.nil?
      avg = 0
    else
      avg = klass.avg
    end
    
    star = options[:star] || 2
    classname = options[:class] || "star"
    
    content_tag :div, "", "data-dimension" => dimension, :class => classname, "data-rating" => avg, :id => "readonly_rating_for",
                          "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
                          "data-star-count" => star
    
    
  end    
end


