class Public::PostDetailsController < ApplicationController

  def update
    @post = PostDetail.find(params[:id])
    @post.update(post_params)
    redirect_to edit_post_path(@post.post_header.id)
  end
  
  

  private

  def post_params
    params.require(:post_detail).permit(:id, :post_header_id, :category_id, :size)
  end



end
