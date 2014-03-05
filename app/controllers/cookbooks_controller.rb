class CookbooksController < ApplicationController
  respond_to :json

  before_action :require_login
  before_action :load_cookbooks_from_current_user, only: [:index]
  before_action :new_cookbook, only: [:create]
  load_and_authorize_resource

  def index
    @cookbooks = @cookbooks.decorate
    @cookbooks.unshift CookbookDecorator.decorate(
      AllRecipesSmartCookbook.new(current_user)
    )
  end

  def show
    show_cookbook
  end

  def create
    if @cookbook.save
      show_cookbook
    else
      render nothing: true, status: 500
    end
  end

  def update
    @cookbook = @cookbook.decorate
    if @cookbook.update cookbook_params
      show_cookbook
    end
  end

  def destroy
    if @cookbook.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 500
    end
  end

  private
    def cookbook_params
      params.require(:cookbook).permit(:title)
    end

    def show_cookbook
      @recipes = @cookbook.recipes.decorate
      @cookbook = @cookbook.decorate
      render :show
    end

    def load_cookbooks_from_current_user
      @cookbooks = current_user.cookbooks
    end

    def new_cookbook
      @cookbook = current_user.cookbooks.new
    end

end
