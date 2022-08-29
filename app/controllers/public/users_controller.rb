class Public::UsersController < ApplicationController
   before_action :authenticate_user!

  def show
    @user = current_user
    # @posts = @user.posts
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :user_name, :height, :sex, :is_deleted, :image)
  end

end
