module ApplicationHelper

  def full_title(title)
    base_title = "Space 10"
    if title.present?
      title + " | " + base_title
    else
      base_title
    end
  end

	def nav_link(text, link_path, options={})
		classes = (options[:class] || '')
		current_path_controller = Rails.application.routes.recognize_path(request.env['PATH_INFO'])[:controller]
		link_path_controller = Rails.application.routes.recognize_path(link_path)[:controller]
		active = current_path_controller == link_path_controller ? ' active' : ''
		classes << active
		link_to text, link_path, class: "#{classes}"
	end

  def current_section
    current_path_controller = Rails.application.routes.recognize_path(request.env['PATH_INFO'])[:controller]
    case current_path_controller
    when "posts"
      "Journal"
    when "events"
      "Program"
    when "profiles"
      "Community"
    when "labs"
      "Labs"
    else
      "Navigate"
    end
  end

	def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields #{options[:class]}", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
