class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, except: [:create]
  before_action :authenticate_user!

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to @post, notice: "Comment was updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params[:comment].permit(:comment)
  end
end
