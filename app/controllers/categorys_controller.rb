class CategorysController < ApplicationController
  def links
    @category = Category.find(params[:id])
    @links = @category.links
  end
end
