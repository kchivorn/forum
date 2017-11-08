class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comments = @post.comments
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: "The post was created successfully."
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, notice: "The post was updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
