class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to  post_path(@post.id)
    elsif
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:post_content, :user_id, :image)
  end

end
