module ApplicationHelper

	def nav_link(text, link_path, options={})
		classes = (options[:class] || '')
		active = request.fullpath.gsub("utf8=%E2%9C%93&", "") == link_path ? ' active' : ''
		classes << active
		link_to text, link_path, class: "#{classes}"
	end
end
