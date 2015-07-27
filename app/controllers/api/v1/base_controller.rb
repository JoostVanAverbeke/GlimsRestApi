class Api::V1::BaseController < ActionController::Base
  before_action :authenticate_user!
  respond_to :json
  
private

  def authenticate_user!
    authenticate_or_request_with_http_token do |token, options|
      if (user = User.find_by(access_token: token))
        @current_user = user
        sign_in user, store: false
      # else
      #   # ensure requests with a failed token match are quantised to 200ms
      #   sleep((200 - Time.now + t) % 200) / 1000.0)
      end
    end
  end

  def current_user
    @current_user
  end

end