class Public::PostsController < ApplicationController

  before_action :authenticate_user!

  def new
    @post_header = PostHeader.new
    @post_header.post_details.build
    @categories = Category.all
    @tops = Category.where(type_id: 8) #whereは条件検索
    @jakets = Category.where(type_id: 9)
    @pants = Category.where(type_id: 10)
    @shoes = Category.where(type_id: 11)
  end

  def create
    @post = PostHeader.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to  post_path(@post.id)
    elsif
      render :new
    end
  end

  def index
    @posts = PostHeader.all
  end

  def show
    @post = PostHeader.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
  end

   def destroy
    @post = PostHeader.find(params[:id])
    @post.destroy
    redirect_to users_my_page_path(current_user)
  end

  private

  def post_params
    params.require(:post_header).permit(:comment, :user_id, :image, post_details_attributes: [:id, :post_header_id, :category_id, :size])
  end

end
