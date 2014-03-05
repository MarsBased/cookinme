class SmartCookbooksController < ApplicationController
  respond_to :json

  def all_recipes
    @cookbook = AllRecipesSmartCookbook.new(current_user).decorate
    @recipes = @cookbook.recipes.decorate
    render("cookbooks/show")
  end
end
