class Api::V1::PostsController < ApplicationController
  before_action :authorize_request, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
        render json: @post, status: :created
    else
        render json: { errors: @post.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @post.user == @current_user
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not authorized to perform this action.' }, status: :unauthorized
    end
  end

  def destroy
    if @current_user.id == @post.user_id
      @post.destroy
      render json: { message: "Post deleted successfully" }
    else
      render json: { error: "Not authorized to perform this action." }, status: :unauthorized
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:description).merge(user_id: @current_user.id)
    end

end
