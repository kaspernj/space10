class AdminController < ApplicationController
	before_filter :authorize
	layout 'admin_application'


private
	def authorize
		unless current_user && current_user.admin?
      redirect_to root_path, alert: "You are not authorized to view that page."
    end
	end
end