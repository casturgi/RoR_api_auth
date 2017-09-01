class Api::V1::SessionsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    #  if user& is the same as if user_exists && user.valid_password?........
    if user&.valid_password?(params[:password])
      # pass email and token to client
      render json: user.as_json(only:  [:email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    user = User.where(authentication_token: params[:authentication_token]).first
    # saving the token refreshes it and will make the user log in again to access
    # data from other endpoints
    if user != nil
      # remove and refresh token
      user.authentication_token = nil
      user.save
      render json: user.as_json(only: [:email]), status: 200
    else
      render json: "user token doesn't match any user tokens in db".to_json , status: 422
    end

  end

end
