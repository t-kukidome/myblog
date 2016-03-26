class ArticlesController < ApplicationController

  def index
    @articles = Article.page(params[:page]).per(10).order(:id)
    @sarticles = Article.all
    c = params[:q]
    #p params[:q]
    return if c.blank?
    if c[:search].blank? == false #まずはsearchに値が入ってるかどうか
      if @sarticles.where(['title like ?', "%#{c[:search]}%"]).empty? == false  #title上で検索してヒットしたら格納されるので、空じゃなかったら
         @sarticles = @sarticles.where(['title like ?', "%#{c[:search]}%"]).page(params[:page]).per(10).order(:id)
         @articles = @sarticles
      else
         @sarticles = @sarticles.where(['body like ?', "%#{c[:search]}%"]).page(params[:page]).per(10).order(:id)
         @articles = @sarticles
      end
    end

    if c[:csearch].blank? == false
      @articles = @articles.where("category_id = '#{c[:csearch]}'").page(params[:page]).per(10).order(:id)
      #@articles = @sarticles
      @category = Category.find(c[:csearch])
    end
  end

  def show
    @article = Article.find(params[:id])
    @category = Category.find(@article.category_id)
  end

  def new
    @article = Article.new
  end

  def create
    #p Article.new(blog_params)
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render 'new'
      #@article.errors.inspect
    end
  end

  def edit
     @article = Article.find(params[:id])
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

  def search
    @article = Article.search(params[:search])
  end

  def bsearch
    @article = Article.bsearch(params[:bsearch])
  end

  private

  def article_params
    params[:article].permit(:title, :body, :category_id, :picture)
  end


end
