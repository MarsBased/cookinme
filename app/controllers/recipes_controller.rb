class RecipesController < ApplicationController
  respond_to :json

  before_action :require_login
  before_action :build_recipe_with_or_without_cookbook, only: [:create]
  load_and_authorize_resource

  def show
    @recipe = @recipe.decorate
  end

  def create
    if @recipe.save
      @recipe = @recipe.decorate
      render(:show)
    else
      render(nothing: true, status: 500)
    end
  end

  def update
    if @recipe.update(recipe_params)
      @recipe = @recipe.decorate
      render(:show)
    else
      render(nothing: true, status: 500)
    end
  end

  def destroy
    if @recipe.destroy
      render(nothing: true, status: 200)
    else
      render(nothing: true, status: 500)
    end
  end

  def upload_photo
    begin
      photo = @recipe.create_or_update_photo!(params[:qqfile])
      @recipe = @recipe.decorate
      render(:show)
    rescue Exception => e
      logger.error e.message
      render(nothing: true, status: 500)
    end
  end

  def remove_photo
    @recipe.recipe_photos.first.try(:destroy)
    @recipe = @recipe.decorate
    render(:show)
  end

  def update_cookbook
    @recipe = @recipe.decorate
    cookbook = Cookbook.find(params[:cookbook_id])
    @recipe.update(cookbook: cookbook)
    render(:show)
  end

  def remove_cookbook
    @recipe = @recipe.decorate
    @recipe.update(cookbook: nil)
    render :show
  end

  private
    def recipe_params
      params.require(:recipe).permit(
        [:title, :description, :time, :guests, :difficulty])
    end

    # As long as the recipe can be built inside a cookbook or
    # in the all-recipes smart cookbook, this method ensures
    # the recipe is correctly built depending on the cookbook_id
    # parameter.
    def build_recipe_with_or_without_cookbook
      if Cookbook.where(id: params[:cookbook_id]).exists?
        cookbook = Cookbook.find(params[:cookbook_id])
        @recipe = cookbook.recipes.build(recipe_params)
        @recipe.user = current_user
      else
        @recipe = current_user.recipes.build(recipe_params)
      end
    end
end