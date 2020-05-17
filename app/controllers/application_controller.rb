class ApplicationController < ActionController::Base

  before_action :set_current_user

  # 現在ログインしているユーザーの情報を@current_userへ代入。
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # ログインしていないユーザーへのアクセス制限
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  # ログインしているユーザーのアクセス制限
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts/index")
    end
  end


end
