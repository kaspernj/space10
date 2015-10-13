module ApplicationHelper

	def nav_link(text, link_path, options={})
		classes = (options[:class] || '')
		active = request.fullpath.gsub("utf8=%E2%9C%93&", "") == link_path ? ' active' : ''
		classes << active
		link_to text, link_path, class: "#{classes}"
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
