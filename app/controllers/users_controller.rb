class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "no_image.jpeg",
      password: params[:password]
    )
    if @user.save
      # 新規登録後もログイン情報を保持させるためにsessionを使う
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    # 画像を保存する処理
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      #送信された画像データを受け取る
      image = params[:image]
      #画像ファイル生成のためにFileクラス.binwriteメソッドを使用
      #ファイルの場所,ファイルの中身(readメソッドを使うことで画像データを取得)
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    # 入力内容と一致するユーザーを取得し、変数@userに代入する
    @user = User.find_by(email: params[:email], password: params[:password])
    # @userが存在するかどうかを判定するif文
    if @user
      # 変数sessionに、ログインに成功したユーザーのidを代入
      session[:user_id] = @user.id
      # フラッシュメッセージ
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
       # @error_messageを定義
      @error_message = "メールアドレスまたはパスワードが間違っています"
      # @emailと@passwordを定義
      @email = params[:email]
      @password = params[:password]
      # 一致するユーザーがいなければログインフォームへレンダー
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

end
