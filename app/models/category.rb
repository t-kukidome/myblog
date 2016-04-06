class Category < ActiveRecord::Base
  validates :name, presence: {message: "カテゴリ名を入力してください"}

  has_many :articles
end
