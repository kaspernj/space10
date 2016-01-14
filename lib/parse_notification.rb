class ParseNotification

  attr_accessor :user_id, :type, :data, :push

  # Intialize Parse at the time of Class Load itself
  Parse.init application_id: ENV["PARSE_APP_ID"],
  api_key: ENV["PARSE_API_KEY"],
  quiet: false

  def initialize(params)
    @user_id = params[:user_id]
    @type = @user_id.present? ? 'individual' : 'channel'
    @data = params[:data]
  end

  def send
    # initialize push object
    @push = if individual?
      Parse::Push.new(@data)
    else
      Parse::Push.new(@data, 'Space10')
    end

    # setting device type if channel type notification
    @push.type = PUSH_TYPE_DEFAULT if channel?
    # adding where clause if notification type is individual
    @push.where = query.where if individual?
    response = @push.save
    Rails.logger.info "ParseNotification:Response:#{response.inspect}"
    response
  end

private

  def individual?
    type == 'individual'
  end

  def channel?
    type == 'channel'
  end

  def query
    # initialize query object
    @query = Parse::Query.new(Parse::Protocol::CLASS_INSTALLATION)
    # set query where clause by some attribute
    @query.eq('space10UserId', @user_id.to_i)
    @query
  end

end