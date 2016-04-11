class ArticlesController < ApplicationController

  before_action :authenticate_user!,  except: [:index, :show]

  def index
    @articles = Article.page(params[:page]).per(10).order("id DESC")
    c = params[:q]
    if params[:mysearch]
      @articles = @articles.where("userid = ?", current_user.id).page(params[:page]).per(10).order(:id)
    end
    return if c.blank?

    if c[:search]
      keyword_array = c[:search].gsub(/[\s　]+/, "|")
      @articles = @articles.where("title similar to :word OR body similar to :word", word: "%(#{keyword_array})%")
    end
    if c[:csearch].blank? == false
      @articles = @articles.where("category_id = ?", c[:csearch]).page(params[:page]).per(10).order(:id)
      @category = Category.find(c[:csearch])
    end
  end

  def show
    @article = Article.find(params[:id])
    @user = User.find(@article.userid)
  end

  def new
    @article = Article.new
    @user = User.new
    @category = Category.new
  end

  def create
    @article = Article.new(article_params)
    @article.userid = current_user.id
    if params[:selectc].to_i == -1
      @article.category_id = -1  
    else
      @category = params[:selectc].to_i == 0 ? Category.find_or_create_by(name: params[:addc]) : Category.find(params[:selectc])
      @article.category_id = @category.id || -1
    end

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
    @category = Category.new
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params)
    if params[:selectc].to_i == 0
      @category = Category.create(name: params[:addc])
      @article.category_id = @category.id || -1
    else
      @article.category_id = params[:selectc] || -1
    end
    if @article.save
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
    params[:article].permit(:title, :body, :picture)
  end
end
