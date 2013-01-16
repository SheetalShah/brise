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

  def avatar_url(user)
    if user.avatar.present?
      user.avatar.url
    else	
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    end
  end
end

