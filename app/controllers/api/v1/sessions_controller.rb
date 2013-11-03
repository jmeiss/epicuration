class Api::V1::SessionsController < DeviseController

  prepend_before_filter :require_no_authentication, only: :create
  respond_to :json

  def create
    resource = User.find_for_database_authentication email: params[:email]

    return invalid_login_attempt unless resource
    return invalid_login_attempt unless resource.valid_password? params[:password]

    render json: { email: resource.email, auth_token: resource.authentication_token }, status: 201
    return
  end

  def destroy
    user = User.find_by_authentication_token params[:auth_token]
    user.authentication_token = SecureRandom.hex

    if user.save
      render json: { }, status: 200
    else
      render json: { errors: ['Authentication token has not been updated'] }, status: 401
    end
  end


protected

  def invalid_login_attempt
    warden.custom_failure!

    render json: { errors: ['Error with your email or password'] }, status: 401
  end
end
