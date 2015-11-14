class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_admin_mode

  around_filter :use_copenhagen_time

  include SessionsHelper

  private

	def use_copenhagen_time(&block)
	  Time.use_zone('Copenhagen', &block)
	end

	def default_serializer_options
	  {root: false}
	end

  def check_admin_mode
    if ENV['ADMIN_MODE'] == 'true' && controller_name != 'sessions' && (current_user.nil? || !current_user.admin?)
      redirect_to 'http://launch.space10.io'
    end
  end
end
