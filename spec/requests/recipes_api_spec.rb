require 'spec_helper'

describe "recipes_api" do

  it "redirects the user to the root path when the user is not logged in" do
    @recipe = create(:recipe)
    get "api/recipes/#{@recipe.id}", format: :json
    expect(response).to redirect_to(root_path)
  end

  context "when the user is logged in" do
    it "retrieves the recipe information" do
      @user = create(:user, password: 'letMeIn')
      post("/sign_in", session: {email: @user.email, password: "letMeIn"})
      @recipe = create(:recipe_with_photos,
        photo_count: 1,
        user: @user).decorate
      get "api/recipes/#{@recipe.id}", format: :json
      response_json = {
          id: @recipe.id,
          title: @recipe.title,
          description: @recipe.description,
          main_photo_url: @recipe.main_photo_url,
          main_photo_url_small: @recipe.main_photo_url_small,
          has_any_photo: true,
          difficulty: @recipe.difficulty,
          time: @recipe.time,
          guests: @recipe.guests,
          cookbook: {
            id: @recipe.cookbook.id,
            title: @recipe.cookbook.title
          }
        }.to_json

      expect(response.body).to eq(response_json)
    end
  end
end