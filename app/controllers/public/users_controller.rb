class Public::UsersController < ApplicationController

   before_action :authenticate_user!

   def index
    # @users = User.all
    @users = User.where.not(id: current_user.id)
   end

   def followeds
     user = User.find(params[:id])
     @users = user.followeds
     #userがフォローしている人全員を取得して@usersに格納
   end

   def followers
     user = User.find(params[:id])
     @users = user.followers
     #userをフォローしている人全員を取得して@usersに格納
   end

  def show
    #@user = current_user
    if "my_page" == params[:id]
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    @posts = @user.post_headers
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_my_page_path(current_user)
    else
      render :edit
    end
  end



  def unsubscribe

  end

  # def withdraw
  #   @user = User.find(params[:id])
  #   # is_deletedカラムをtrueに変更することにより削除フラグを立てる
  #   @user.update(is_deleted: true)
  #   reset_session
  #   flash[:notice] = "退会処理を実行いたしました"
  #   redirect_to root_path
  # end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :user_name, :height, :sex, :is_deleted, :profile_image)
  end

end
