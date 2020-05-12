class UsersController < ApplicationController

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
      image_name: "no_image.jpeg"
    )
    if @user.save
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

end
