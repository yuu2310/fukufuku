class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインに成功しました"
    root_path
  end


  def after_sign_out_path_for(resource)
    flash[:alert] = "ログアウトしました"
    about_path
  end
end
