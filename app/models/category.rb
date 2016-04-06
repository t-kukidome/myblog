class Category < ActiveRecord::Base
  validates :name, presence: {message: "カテゴリ名を入力してください"}, uniqueness: {message: "入力したカテゴリは重複しています"}

  has_many :articles
end
