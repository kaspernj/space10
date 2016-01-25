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
        'image' => 'https://s3.amazonaws.com/uifaces/faces/twitter/brad_frost/128.jpg'
      },
      'credentials' => {
        'token' => 'mock_token',
        'expires_at' => '1321747205'
      },
      'extra' => {
        'raw_info' => {
          'email' => 'johndoe@example.com',
          'name' => 'John Doe',
          'first_name' => 'John',
          'last_name' => 'Doe',
          'gender' => 'male',
          'birthday' => '01/10/2014'
        }
      }
    }
end

def omniauth_linkedin_hash
  OmniAuth.config.mock_auth[:linkedin] = {
      'provider' => 'linkedin',
      'uid' => '123545',
      'info' => {
        'email' => 'johndoe@example.com',
        'first_name' => 'John',
        'last_name' => 'Doe',
        'image' => 'https://s3.amazonaws.com/uifaces/faces/twitter/brad_frost/128.jpg'
      },
      'credentials' => {
        'token' => 'mock_token',
        'expires_at' => '1321747205'
      }
    }
end

def last_email
  ActionMailer::Base.deliveries.last
end

def wait_for_ajax
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until finished_all_ajax_requests?
  end
end

def finished_all_ajax_requests?
  page.evaluate_script('jQuery.active').zero?
end

# def work_off
#   Delayed::Job.all.each do |job|
#     job.payload_object.perform
#     job.destroy
#   end
# end

# def delayed_jobs
#   Delayed::Job.all.count
# end