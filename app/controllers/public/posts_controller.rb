class Public::PostsController < ApplicationController

  def new
    @post = Post.new
    @categories = Category.all
    @tops = Category.where(type_id: 8) #whereは条件検索
    @jakets = Category.where(type_id: 9)
    @pants = Category.where(type_id: 10)
    @shoes = Category.where(type_id: 11)
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
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:post_content, :user_id, :image, :size)
  end

end
