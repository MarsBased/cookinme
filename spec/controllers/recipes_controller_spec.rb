require 'spec_helper'

describe RecipesController do

  let(:user) {create(:user)}
  let(:cookbook) {create(:cookbook, user: user)}

  before :each do
    login_user user
  end

  describe 'GET #show' do
    it "fails when the recipe doesn't belong to the logged user" do
      @recipe = create(:recipe, cookbook: cookbook)
      expect{get(:show, id: @recipe.id)}.to raise_error(CanCan::AccessDenied)
    end

    context "when the recipe belongs to the logged user" do
      before :each do
        @recipe = create(:recipe, user: user, cookbook: cookbook)
      end

      it "renders the show template" do
        get(:show, id: @recipe.id)
        expect(response).to render_template(:show)
      end

      it "assigns the recipe to @recipe" do
        get(:show, id: @recipe.id)
        expect(assigns(:recipe).model).to eq(@recipe)
      end

      it "decorates the @recipe" do
        get(:show, id: @recipe.id)
        expect(assigns(:recipe)).to be_decorated
      end
    end
  end

  describe "POST #create" do
    context "when no cookbook is passed as a parameter" do
      it "creates a new recipe" do
        expect{post(:create, recipe: {title: 'new recipe'})}.to change{
          Recipe.count}.by(1)
      end
      it "don't assign the recipe to a cookbook" do
        post(:create, recipe: {title: 'new recipe'})
        expect(assigns(:recipe).cookbook).to be_nil
      end
    end
    context "when a cookbook is passed as a parameter" do
      before :each do
        @recipe_params = {
          recipe:
            {title: 'new recipe'},
            cookbook_id: cookbook.id
        }
      end

      it "creates a new recipe" do
        expect{post(:create, @recipe_params)}.to change{Recipe.count}.by(1)
      end

      it "doesn't assign the recipe to a cookbook" do
        post(:create, @recipe_params)
        expect(assigns(:recipe).cookbook).to eq(cookbook)
      end
    end

    it "assigns a new decorated recipe" do
      post(:create, recipe: {title: 'new recipe'})
      expect(assigns(:recipe)).to be_decorated_with(RecipeDecorator)
    end

    it "renders the show template" do
      post(:create, recipe: {title: 'new recipe'})
      expect(response).to render_template(:show)
    end
  end

  describe "PUT #update" do
    before :each do
      @recipe = create(:recipe,
        title: 'Tiramisu',
        user: user,
        cookbook: cookbook
      )
      @recipe_params = {
        id: @recipe.id,
        recipe: {title: 'Crema catalana'}
      }
    end

    it "fails when the recipe doesn't belong to the logged user" do
      @recipe = create(:recipe)
      expect{put(:update, id: @recipe.id)}.to raise_error CanCan::AccessDenied
    end

    it "updates a permited param" do
      put(:update, @recipe_params)
      expect(@recipe.reload.title).to eq('Crema catalana')
    end

    it "doesn't update an unpermitted param" do
      put(:update, @recipe_params.merge(cookbook_id: cookbook.id + 1))
      expect(@recipe.reload.cookbook_id).to eq(cookbook.id)
    end

    it "renders the show template" do
      put(:update, @recipe_params)
      expect(response).to render_template(:show)
    end

    it "assigns a new decorated recipe" do
      put(:update, @recipe_params)
      expect(assigns(:recipe)).to be_decorated_with(RecipeDecorator)
    end

    it "assigns the updated recipe to @recipe" do
      put(:update, @recipe_params)
      expect(assigns(:recipe).model).to eq(@recipe)
    end
  end

  describe "DELETE #destroy" do
    it "fails when the recipe doesn't belong to the logged user" do
      recipe = create(:recipe)
      expect{delete(:destroy, id: recipe.id)}.
        to raise_error(CanCan::AccessDenied)
    end

    it "removes the recipe" do
      recipe = create(:recipe, user: user)
      expect{delete(:destroy, id: recipe.id)}.to change{Recipe.count}.by(-1)
    end

    it "renders nothing with success if cookbook removed" do
      recipe = create(:recipe, user: user)
      delete(:destroy, id: recipe.id)
      expect(response.body).to be_blank
      expect(response).to be_success
    end
  end

  describe "PUT #upload_photo" do
    before :each do
      @recipe = create(:recipe, user: user)
    end

    it "fails if the recipe user is not the same as the logged user" do
      recipe = create(:recipe)
      expect{put(:upload_photo, id: recipe.id)}.
        to raise_error(CanCan::AccessDenied)
    end

    it "creates_or_update a photo" do
      Recipe.any_instance.should_receive(:create_or_update_photo!).with('a')
      put(:upload_photo, id: @recipe.id, qqfile: 'a')
    end

    it "renders the show template" do
      put(:upload_photo, id: @recipe.id, qqfile: 'a')
      expect(response).to render_template(:show)
    end

    it "decorates the assigned recipe" do
      put(:upload_photo, id: @recipe.id, qqfile: 'a')
      expect(assigns(:recipe)).to be_decorated_with RecipeDecorator
    end

    it "assigns the updates recipe to @recipe" do
      put(:upload_photo, id: @recipe.id, qqfile: 'a')
      expect(assigns(:recipe).model).to eq(@recipe)
    end
  end

  describe "DELETE #remove_photo" do
    before :each do
      @recipe_with_photo = create(
        :recipe_with_photos,
        user: user,
        photo_count: 1
      )
    end

    it "fails if the recipe user is not the same as the logged user" do
      recipe = create(:recipe)
      expect{delete(:remove_photo, id: recipe.id)}.
        to raise_error(CanCan::AccessDenied)
    end

    it "removes a photo" do
      delete(:remove_photo, id: @recipe_with_photo.id)
      expect(@recipe_with_photo.reload.recipe_photos).to eq([])
    end

    it "renders the show template" do
      delete(:remove_photo, id: @recipe_with_photo.id)
      expect(response).to render_template(:show)
    end

    it "decorates the assigned recipe" do
      delete(:remove_photo, id: @recipe_with_photo.id)
      expect(assigns(:recipe)).to be_decorated_with RecipeDecorator
    end

    it "assigns the updates recipe to @recipe" do
      delete(:remove_photo, id: @recipe_with_photo.id)
      expect(assigns(:recipe).model).to eq(@recipe_with_photo)
    end
  end

  describe "PUT #update_cookbook" do
    before :each do
      @recipe = create(:recipe, user: user, cookbook: cookbook)
      @new_cookbook = create(:cookbook)
    end

    it "fails if the recipe user is not the same as the logged user" do
      recipe = create(:recipe)
      expect{put(:update_cookbook, id: recipe.id)}.
        to raise_error(CanCan::AccessDenied)
    end

    it "the cookbook is updated" do
      put(:update_cookbook, id: @recipe.id, cookbook_id: @new_cookbook.id)
      expect(@recipe.reload.cookbook).to eq(@new_cookbook)
    end

    it "renders the show template" do
      put(:update_cookbook, id: @recipe.id, cookbook_id: @new_cookbook.id)
      expect(response).to render_template(:show)
    end

    it "decorates the assigned recipe" do
      put(:update_cookbook, id: @recipe.id, cookbook_id: @new_cookbook.id)
      expect(assigns(:recipe)).to be_decorated_with RecipeDecorator
    end

    it "assigns the updates recipe to @recipe" do
      put(:update_cookbook, id: @recipe.id, cookbook_id: @new_cookbook.id)
      expect(assigns(:recipe).model).to eq(@recipe)
    end
  end

  describe "DELETE #remove_cookbook" do
    before :each do
      @recipe = create(:recipe, user: user, cookbook: cookbook)
      @new_cookbook = create(:cookbook)
    end

    it "fails if the recipe user is not the same as the logged user" do
      recipe = create(:recipe)
      expect{delete(:remove_cookbook, id: recipe.id)}.
        to raise_error(CanCan::AccessDenied)
    end

    it "the cookbook is removed" do
      delete(:remove_cookbook, id: @recipe.id)
      expect(@recipe.reload.cookbook).to be_nil
    end

    it "renders the show template" do
      delete(:remove_cookbook, id: @recipe.id)
      expect(response).to render_template(:show)
    end

    it "decorates the assigned recipe" do
      delete(:remove_cookbook, id: @recipe.id)
      expect(assigns(:recipe)).to be_decorated_with RecipeDecorator
    end

    it "assigns the updates recipe to @recipe" do
      delete(:remove_cookbook, id: @recipe.id)
      expect(assigns(:recipe).model).to eq(@recipe)
    end
  end

end