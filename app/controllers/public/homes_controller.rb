class Public::HomesController < ApplicationController

  def top
    @posts = PostHeader.order('id DESC').limit(4).page(params[:page]).per(4)
  end

  def about
  end

end
