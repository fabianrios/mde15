class RecipesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  def index
    @recipes = params[:keywords].present? ? Recipe.where('name ilike ?',"%#{params[:keywords]}%") : []
  end
  
  def create
    @recipe = Recipe.new(params.require(:recipe).permit(:name,:instructions))
    @recipe.save
    render 'show', status: 201
  end
 
  def update
    recipe = Recipe.find(params[:id])
    recipe.update_attributes(params.require(:recipe).permit(:name,:instructions))
    head :no_content
  end
 
  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    head :no_content
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
end