class Public::UsersController < ApplicationController

  before_action :authenticate_user!

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).order(created_at: :desc).pluck(:post_header_id)
    # ユーザーidがユーザーのいいねのレコードを全て取得します
    # そして、そのpost_header_idも一緒に持ってくる
    # favoritesの中身にはあるユーザーがいいねした記事のidが格納されている
    @favorite_posts = PostHeader.find(favorites)
    @post_comment = PostComment.new
  end

  def index
    @users = User.where.not(id: current_user.id)
    @q = User.page(params[:page]).per(8).ransack(params[:q])
    # params[:q]：検索フォームでの入力した値を受け取る
    # User.ransack(prams[:q])：検索フォームの条件、入力した値(params[:q])を元に、usersテーブルからデータを検索します。データの検索条件はオプションで指定できます
    @users = @q.result(distinct: true).order(created_at: "DESC") #usersの検索結果一覧
    # @q.result：ransackメソッドで取得したデータ(Ransack::Searchオブジェクト)を元に、ActiveRecord_Relationオブジェクトに変換する
    # 最終的に、@usersを検索結果画面に挿入します。
    # 検索結果の一覧：  @users = @q.result.order(created_at: "DESC")
    # distinct: trueは検索結果のレコード重複しないようにします。
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
    if "my_page" == params[:id]
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    @posts = @user.post_headers.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to user: :show
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    if @user.update(is_deleted: true)
      reset_session
      redirect_to root_path, notice: "アカウントを削除しました。またのご利用を心よりお待ちしております"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :user_name, :height, :sex, :is_deleted, :profile_image)
  end

end
