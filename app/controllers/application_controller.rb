class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :use_copenhagen_time

  include SessionsHelper

  private

	def use_copenhagen_time(&block)
	  Time.use_zone('Copenhagen', &block)
	end

	def default_serializer_options
	  {root: false}
	end
end
