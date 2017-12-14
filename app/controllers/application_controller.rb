class ApplicationController < ActionController::API
  
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorized

  private

  def issue_token(payload)
    JWT.encode(payload, ENV["SOME_SECRET"], ENV["SOME_SUPER_SECRET"])
  end

  def decode(jwt_token)
    JWT.decode(jwt_token, ENV["SOME_SECRET"], true, { algorithm: ENV["SOME_SUPER_SECRET"]})
  end

  def current_user_id
    authenticate_or_request_with_http_token do |jwt_token, options|
      decoded_token = decode(jwt_token)
      current_user_id = decoded_token[0]["user_id"]
    end
  end

  def current_user
    authenticate_or_request_with_http_token do |jwt_token, options|
      begin
        decoded_token = decode(jwt_token)
      rescue JWT::DecodeError
        return nil
      end
      if decoded_token[0]["user_id"]
        @current_user ||= User.find(decoded_token[0]["user_id"])
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: "Not welcome" }, status: 401 unless logged_in?
  end

end
