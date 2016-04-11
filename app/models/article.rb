class Article < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  validates :title, presence: {message: "タイトルを入力してください"}
  validates :body, presence: {message: "本文を入力してください"}

  belongs_to :category
end
