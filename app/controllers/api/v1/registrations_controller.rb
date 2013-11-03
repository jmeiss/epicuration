class Api::V1::RegistrationsController < Api::V1::BaseController

  respond_to :json

  def create
    user = User.new safe_params

    if user.save
      render json: { email: user.email, authentication_token: user.authentication_token }, status: 201
      return
    else
      warden.custom_failure!
      render json: user.errors, status: 422
    end
  end


private

  def safe_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end