class ArticlesController < ApplicationController

  before_action :authenticate_user!,  except: [:index, :show]

  def index
    require "time"

    @articles = Article.page(params[:page]).per(10).order(:id).reverse_order
    @sarticles = Article.all
    @nowtime = Time.now
    c = params[:q]
    #p params[:q]
    p params[:mysearch]
=begin
    if params[:mysearch].blank? == false
      #p "aaaaaa"

      if @articles.where(['title like ?', "%#{params[:mysearch]}%"]).empty? == false  #title上で検索してヒットしたら格納されるので、空じゃなかったら
        @articles = @articles.where(['title like ?', "%#{params[:mysearch]}%"]).page(params[:page]).per(10).order(:id)
        @articles = @articles.where("userid = '#{current_user.id}'").page(params[:page]).per(10).order(:id)
      else
        @articles = @articles.where(['body like ?', "%#{params[:mysearch]}%"]).page(params[:page]).per(10).order(:id)
        @articles = @articles.where("userid = '#{current_user.id}'").page(params[:page]).per(10).order(:id)
      end
    elsif params[:mysearch] == ""
      @articles = @articles.where("userid = '#{current_user.id}'").page(params[:page]).per(10).order(:id)
      end
=end
    if params[:mysearch]
      @articles = @articles.where("userid = '#{current_user.id}'").page(params[:page]).per(10).order(:id)

    end
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
    @user = User.new
  end

  def create
    #p Article.new(blog_params)
    @article = Article.new(article_params)
    @article.userid = current_user.id
    if @article.save
      redirect_to articles_path
    else
      render 'new'
      #@article.errors.inspect
    end
  end

  def edit
    if current_user.id != Article.find(params[:id]).userid

      redirect_to articles_path
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


end
