class PostsController < ApplicationController

  def index
  	@posts = Post.all
  end

  def show
    # find_byを用いてpostsテーブルから「params[:id]」に対応するデータを取り出し、変数@postに代入する。
    @post = Post.find_by(id:params[:id])
  end

  def new
  end

end
