class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_admin_mode

  around_filter :use_copenhagen_time

  before_action :prepare_meta_tags, if: "request.get?"

  after_filter :flash_to_headers

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
      redirect_to 'https://rebelunited-yuji.squarespace.com/'
    end
  end

  def flash_to_headers
    return unless request.xhr?
    msg = flash_message
    #replace german umlaute encoded in utf-8 to html escaped ones
    msg = msg.gsub("ä","&auml;").gsub("ü","&uuml;").gsub("ö","&ouml;").gsub("Ä","&Auml;").gsub("Ü","&Uuml;").gsub("Ö","&Ouml;").gsub("ß","&szlig;")
    response.headers['X-Message'] = msg
    response.headers["X-Message-Type"] = flash_type.to_s

    flash.discard # don't want the flash to appear when you reload page
  end

  def flash_message
    [:error, :warning, :notice].each do |type|
      return flash[type] unless flash[type].blank?
    end
    # if we don't return something here, the above code will return "error, warning, notice"
    return ''
  end

  def flash_type
    #:keep will instruct the js to not update or remove the shown message.
    #just write flash[:keep] = true (or any other value) in your controller code
    [:error, :warning, :notice, :keep].each do |type|
      return type unless flash[type].blank?
    end
    #don't return the array from above which would happen if we don't have an explicit return statement
    #returning :empty will also allow you to easily know that no flash message was transmitted
    return :empty
  end

  def prepare_meta_tags(options={})

    site_name   = "Space10"
    title       = options[:title]
    description = options[:description] || "A future-living lab and exhibition space."
    image       = options[:image] || ActionController::Base.helpers.asset_url('frontpage_image.jpg')
    current_url = request.url
    type        = options[:type] || 'website'

    # Let's prepare a nice set of defaults

    defaults = {
      site:        site_name,
      title:       title,
      reverse:     true,
      image:       image,
      description: description,
      keywords:    %w[future lab ikea exhibition space artrebels],
      twitter:    {
                    site_name: site_name,
                    title: title,
                    site: '@space10_journal',
                    card: 'summary',
                    description: description,
                    image: image
                  },
      og:         {
                    title: title,
                    url: current_url,
                    site_name: site_name,
                    image: image,
                    description: description,
                    type: type
                  }
    }

    options.deeper_merge(defaults)

    set_meta_tags options

  end
end
