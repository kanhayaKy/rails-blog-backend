class Api::V1::PostsController < ApplicationController
  before_action :authorize_request, except: [:index, :show]
  before_action :authorize_request_conditionally, only: [:index, :show]
  before_action :set_post, except: [:index, :create]

  def index
    @posts = Post.all
    render json: @posts, each_serializer: Api::V1::PostSerializer, current_user: @current_user
  end

  def show
    render json: @post, serializer: Api::V1::PostSerializer, current_user: @current_user
  end

  def create
    post_params.require(:title)

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

  def like
    if !@post.likes.include?(@current_user)
      @post.likes << @current_user
    end
    render json: @post, serializer: Api::V1::PostSerializer, current_user: @current_user
  end

  def dislike
    @post.likes.delete(@current_user)
    render json: @post, serializer: Api::V1::PostSerializer, current_user: @current_user
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.permit(:title, :content).merge(user_id: @current_user.id)
    end

end
