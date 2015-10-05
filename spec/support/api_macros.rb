def request_headers(options = {})
	request_headers = {
		"Accept" => "application/vnd.space10.v1+json",
    "Content-Type" => "application/json"
	}
	if options[:user].present?
		request_headers.merge!({ "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Token.encode_credentials(options[:user].auth_token) })
	else
		request_headers.merge!({ "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("ios_app","secret123") })
	end

end

def response_body
	JSON.parse(response.body)
end