class Api::V1::FollowsController < ApplicationController
  include Rails.application.routes.url_helpers

  before_action :authorize_request
  before_action :get_user

  def create
    @current_user.follow(@user)
    render json: { message: "Followed successfully"}, status: :ok
  end

  def destroy
    @current_user.unfollow(@user)
    render json: { message: "Unfollowed successfully"}, status: :ok
  end

  private
    def get_user
      @user = User.find_by_username!(params[:user__username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: ['Could not find that user'] }, status: :not_found
    end
end
