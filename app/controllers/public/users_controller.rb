class Public::UsersController < ApplicationController
   before_action :authenticate_user!

   def index
     @user = User.all
   end

  def show
    @user = current_user
    # @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_my_page_path(@user.id)
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :user_name, :height, :sex, :is_deleted, :profile_image)
  end

end
