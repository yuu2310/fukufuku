# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  # def reject_user
  #   @user = User.find_by(name: params[:user][:email])
  #   # ログイン時に入力された名前に対応するユーザーが存在するか探している。
  #   if @user
  #     if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
  #       # 入力されたパスワードが正しいことを確認している。＠userのactive_for_authentication?メソッドがfalseであるかどうか。
  #       flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
  #       redirect_to new_user_registration
  #     else
  #       flash[:notice] = "項目を入力してください"
  #     end
  #   end
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  
end
