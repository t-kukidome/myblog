class CategoriesController < ApplicationController

  before_action :authenticate_user!

  def index
    redirect_to articles_path
  end

  def new
    @categories = Category.all.includes(:articles).order(:id)
  end

  def destroy
    @category = Category.find(params[:id])
    Article.where("category_id = ?", params[:id]).update_all(category_id: "-1")
    @category.destroy
    redirect_to new_category_path
  end
end
