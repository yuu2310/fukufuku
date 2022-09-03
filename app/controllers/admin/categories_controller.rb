class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!


  def index
    @categories = Category.all
    @category = Category.new

  end

  def create
    @category = Category.new(category_params)
    if @category.save
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
    @category.update(category_params)
    redirect_to  admin_categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to  admin_categories_path
  end

  def category_params
    params.require(:category).permit(:category_name, :type_id)
  end

end
