module ApplicationHelper
  def link_to_remove_fields(name, f, id)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :id => "remove_" + id )
  end
  
  def link_to_add_fields(name, f, association, id)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :id => "add_" + id, :class => id )
  end

  def avatar_url(object)
    if object.avatar.present?
      object.avatar.url
    else	
      "guest.png"
    end
  end

  def isValidFollowingType(object)
    classname = object.class.name
    # only users can follow other users, products, ads	
    if classname == "User"
      return true
    else
      return false 
    end
  end
end

