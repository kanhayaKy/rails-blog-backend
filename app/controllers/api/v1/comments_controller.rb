class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_post
  before_action :set_comment, only: [:update, :destroy]


  def create
    @comment = Comment.new(comment_params)
    if @comment.save
        render json: @comment, status: :created
    else
        render json: { errors: @comment.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @comment.user == @current_user
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not authorized to perform this action.' }, status: :unauthorized
    end
  end

  def destroy
    if @current_user.id == @comment.user_id
      @comment.destroy
      render json: { message: "comment deleted successfully" }
    else
      render json: { error: "Not authorized to perform this action." }, status: :unauthorized
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:comment).merge(user_id: @current_user.id, post_id: @post.id)
  end
end
