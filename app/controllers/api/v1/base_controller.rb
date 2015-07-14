class Api::V1::BaseController < ActionController::Base
  before_action :authenticate_user
  respond_to :json
  
private

  def authenticate_user
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(access_token: token)
    end
  end

  def current_user
    @current_user
  end

end