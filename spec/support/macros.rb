def sign_in(user, options={})
	visit login_path
	within("form") do
		fill_in "Email", with: user.email
		fill_in "Password", with: (options[:password] || user.password)
		click_on "Log in"	
	end
end

def omniauth_facebook_hash
	OmniAuth.config.mock_auth[:facebook] = {
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'email' => 'johndoe@example.com',
        'name' => 'John Doe',
        'first_name' => 'John',
        'last_name' => 'Doe',
        'image' => 'mock_user_thumbnail_url'
      },
      'credentials' => {
        'token' => 'mock_token',
        'expires_at' => '1321747205'
      }
    }
end