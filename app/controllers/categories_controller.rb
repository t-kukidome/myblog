class CategoriesController < ApplicationController

  def index

  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to new_category_path
    else
      p @category.errors.messages
      render 'new'
    end
  end


  def show

  end

private

def category_params
  params[:category].permit(:name)
end
end
