class Api::V1::Managers::RegistrationsController < ApplicationController
  def create
    @manager = Manager.new(users_params)

    if @manager.save
      render json: { jwt: @manager.authentication_token }
    else
      render json: { errors: @manager.errors.full_messages }, status: 422
    end
  end

  def users_params
    params.require(:sign_up).permit(:email, :password, :password_confirmation)
  end
end
