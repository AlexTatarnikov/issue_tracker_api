class Api::V1::Users::RegistrationsController < ApplicationController
  def create
    @user = User.new(users_params)

    if @user.save
      render json: { jwt: @user.authentication_token }
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def users_params
    params.require(:sign_up).permit(:email, :password, :password_confirmation)
  end
end
