class Api::V1::LoginController < ApplicationController
  respond_to :json

  def login
    user = User.find_by_email(params[:email])
    if user && user.valid_password?(params[:password])
      render json: user
    else
      render nothing: true, status: :unauthorized
    end
  end
end
