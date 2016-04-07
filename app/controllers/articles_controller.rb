class ArticlesController < ApplicationController

  before_action :authenticate_user!,  except: [:index, :show]

  def index
    @articles = Article.page(params[:page]).per(10).order(:id).reverse_order
    #@sarticles = Article.all
    c = params[:q]
    if params[:mysearch]
      @articles = @articles.where("userid = ?", current_user.id).page(params[:page]).per(10).order(:id)
    end
    return if c.blank?
    if c[:search] #まずはsearchに値が入ってるかどうか
      #if @sarticles.where('title like ? or body like ?', c[:search], c[:search]).empty? == false  #title上で検索してヒットしたら格納されるので、空じゃなかったら
         #@sarticles = @sarticles.where(['title like ?', "%#{c[:search]}%"]).page(params[:page]).per(10).order(:id)
         p c[:search]
         @articles = @articles.where("title LIKE ? OR body LIKE ?", "%#{c[:search]}%", "%#{c[:search]}%").page(params[:page]).per(10).order(:id)
         #@articles = @sarticles
      #end
      #if @sarticles.where(['body like ?', "%#{c[:search]}%"]).empty? == false
      # @sarticles = @sarticles.where(['body like ?', "%#{c[:search]}%"]).page(params[:page]).per(10).order(:id)
      # @articles = @sarticles
      #end
    end

    if c[:csearch].blank? == false
      @articles = @articles.where("category_id = ?", c[:csearch]).page(params[:page]).per(10).order(:id)
      @category = Category.find(c[:csearch])
    end

  end

  def show
    @article = Article.find(params[:id])
    #@category = Category.find(@article.category_id)
    @user = User.find(@article.userid)
  end

  def new
    @article = Article.new
    @user = User.new
    @category = Category.new
  end

  def create
    p params
    @article = Article.new(article_params)
    @article.userid = current_user.id
    @category = params[:selectc].to_i == 0 ? Category.find_or_create_by(name: params[:addc]) : Category.find(params[:selectc].to_i)
    @article.category_id = @category.id

    if @article.save
       redirect_to articles_path, notice: "Article Created"
    else
       render 'new'
    end
  end

  def edit
    if current_user.id != Article.find(params[:id]).userid
        redirect_to articles_path, alert: "You cannot edit this article."
    else
     @article = Article.find(params[:id])
    end
  end

  def update
     @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params[:article].permit(:title, :body, :category_id, :picture, :userid)
  end

  def category_params
    params[:category].permit(:name, :userid)
  end
end
