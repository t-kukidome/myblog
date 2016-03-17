class Category < ActiveRecord::Base
  validates :name, presence: {message: "を入力してください"}

  has_many :articles
end
