class Api::V1::AuthenticationController < ApplicationController
  before_action :authorize_request, except: %i[login register]

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user: Api::V1::UserSerializer.new(@user) }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  # GET /auth/user
  def user_details
    token = JsonWebToken.encode(user_id: @current_user.id)
    time = Time.now + 24.hours.to_i
    render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                  user: Api::V1::UserSerializer.new(@current_user) }, status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
