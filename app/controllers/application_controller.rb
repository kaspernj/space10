class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_admin_mode

  around_filter :use_copenhagen_time

  before_action :prepare_meta_tags, if: "request.get?"

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

  def prepare_meta_tags(options={})

    site_name   = "Space10"
    title       = options[:title] if options[:title].present?
    description = options[:description] || "A future-living lab and exhibition space."
    image       = options[:image] || ActionController::Base.helpers.asset_url('frontpage_image.jpg')
    current_url = request.url
    type        = options[:type] || 'website'

    # Let's prepare a nice set of defaults

    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[future lab ikea exhibition space artrebels],
      twitter:    {
                    site_name: site_name,
                    title: title,
                    site: 'space10_journal',
                    card: 'summary',
                    description: description,
                    image: {src: image}
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
