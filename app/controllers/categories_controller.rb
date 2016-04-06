class CategoriesController < ApplicationController

  before_action :authenticate_user!

  def index
    redirect_to articles_path
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    #p params
    @article = Article.first
    @category = Category.new(:name => params[:add], :userid => current_user.id)
    #@article = Article.new
    if @category.save
      redirect_to new_article_path
      p "category saved"
    else
      p @category.errors.messages
      p "category not saved"
      redirect_to new_article_path

    end
  end

  def edit

  end

  def show

  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to new_category_path
  end

private

def category_params
  params[:category].permit(:name)
  #params[:category].permit(@category.name)
end
end
