class Public::RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    followed = current_user.relationships.build(follower_id: params[:user_id])
    #current_userに紐付いたrelationshipsを作成できる
    #followed_idにはcurrent_userのid, follower_idにはパラメーターからとってきたuser_idを格納することが出来る
    followed.save
    redirect_to request.referrer || root_path
    #これでフォローする人とされる人が格納された
  end

  def destroy
    followed = current_user.relationships.find_by(follower_id: params[:user_id])
    followed.destroy
    redirect_to request.referrer || root_path
  end
end
