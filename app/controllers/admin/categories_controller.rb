class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!


  def index
    @categories = Category.all
    @category = Category.new

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "カテゴリー名を追加しました"
      redirect_to  admin_categories_path
    else
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリー名を更新しました"
      redirect_to  admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:alert] = "カテゴリーを削除しました"
    redirect_to  admin_categories_path
  end

  def category_params
    params.require(:category).permit(:category_name, :type_id)
  end

end
