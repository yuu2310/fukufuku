class Public::FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    post = PostHeader.find(params[:post_id])
    favorite = current_user.favorites.new(post_header_id: post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    post = PostHeader.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_header_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end

end
