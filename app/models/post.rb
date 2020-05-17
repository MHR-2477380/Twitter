class Post < ApplicationRecord

    validates :content, {presence: true, length: {maximum: 140}}
    validates :user_id, {presence: true}

    # 投稿にユーザー情報を結びつけるuserメソッド
    def user
    	return User.find_by(id: self.user_id)
    end

end
