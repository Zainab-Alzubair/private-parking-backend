class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user = User.new(user_params)
    if user.save
      render json: { auth_token: user.generate_authentication_token, role: user.role }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
