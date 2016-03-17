class Article < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  validates :title, presence: {message: "を入力してください"}
  validates :body, presence: {message: "を入力してください"}

  belongs_to :category
end
