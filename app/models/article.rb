class Article < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  validates :title, presence: {message: "を入力してください"}
  validates :body, presence: {message: "を入力してください"}
  #validates :search, presence: {message: "を入力してください"}

  belongs_to :category

=begin
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Article.where(['title like ?', "%#{search}%"])
    else
      Article.all #全表示。
      #puts "検索ワードを入力してください"
    end
  end
=end
end
