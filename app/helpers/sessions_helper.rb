module SessionsHelper
	def current_user
		@current_user ||= User.find_by(auth_token: cookies.signed[:auth_token])
	end

	def current_user=(user)
		@current_user = user		
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end

	def signed_in_user
    if !signed_in?
    	store_location
      redirect_to signup_url, notice: "Sign up or log in."
    end
  end

	def sign_in(user)
		cookies.signed[:auth_token] = { value: user.auth_token, expires: 6.months.from_now }
		self.current_user = user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:auth_token)
	end

	def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
end