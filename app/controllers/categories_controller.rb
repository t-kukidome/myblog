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
    @category = Category.new(:name => params[:add])

    p "aaaaaa" + @category.name
    if @category.save
      p "category saved from category model"
      redirect_to new_article_path
      #redirect_to articles_path
    else
      p "category not saved from category model"
      render 'new'
      #redirect_to new_category_path
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
