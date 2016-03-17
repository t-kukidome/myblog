class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    @pages = Article.page(params[:page]).per(10).order(:id)
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

  private

  def article_params
    params[:article].permit(:title, :body, :category_id, :picture)
  end


end
