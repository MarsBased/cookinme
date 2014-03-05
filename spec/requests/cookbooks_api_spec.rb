require 'spec_helper'

describe "cookbooks_api" do
  it "redirects the user to the root path when the user is not logged in" do
    get "api/cookbooks", format: :json
    expect(response).to redirect_to(root_path)
    cookbook = create(:cookbook)
    get "api/cookbooks/#{cookbook.id}", format: :json
    expect(response).to redirect_to(root_path)
  end

  context "when the user is logged in" do
    before :each do
      @user = create(:user, password: 'letMeIn')
      post("/sign_in", session: {email: @user.email, password: "letMeIn"})
    end

    it "retrieves the cookbook information without recipes" do
      cookbook = create(:cookbook, user: @user).decorate
      get "api/cookbooks/#{cookbook.id}", format: :json
      response_json = {
        id: cookbook.id,
        title: cookbook.title,
        is_smart: false,
        recipes: []
      }.to_json

      expect(response.body).to eq(response_json)
    end

    it "retrieves the recipes from the cookbook" do
      cookbook = create(:cookbook_with_recipes,
        recipes_count: 3,
        user: @user)
      get "api/cookbooks/#{cookbook.id}", format: :json
      json_response = JSON.parse(response.body)
      expect(json_response['recipes']).to have(3).things
    end

    context "when retrieving all-recipes cookbook" do
      it "retrieves the smart cookbook" do
        get "api/cookbooks/all-recipes", format: :json
        response_json = {
          id: "all-recipes",
          title: I18n.t("def.smart_cookbooks.all_recipes"),
          is_smart: true,
          recipes: []
        }.to_json
        expect(response.body).to eq(response_json)
      end

      it "retrieves all the user recipes." do
        create_list(:recipe, 3, user: @user)
        create(:recipe)
        get "api/cookbooks/all-recipes", format: :json
        json_response = JSON.parse(response.body)
        expect(json_response['recipes']).to have(3).things
      end
    end

    context "when getting all the cookbooks" do
      it "retrieves as cookbooks as the user has plus the smart one" do
        create_list(:cookbook, 3, user: @user)
        create(:cookbook)
        get "api/cookbooks", format: :json
        json_response = JSON.parse(response.body)
        expect(json_response).to have(4).things
      end

      it "retrieves all the fields from a cookbook" do
        cookbook = create(:cookbook, user: @user).decorate
        get "api/cookbooks", format: :json
        response_json = {
          title: cookbook.title,
          cover_images: cookbook.cover_images,
          id: cookbook.id,
          created_at: cookbook.created_at.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
          is_smart: false
        }.to_json

        json_response = JSON.parse(response.body)
        expect(json_response.last.to_json).to eq(response_json)
      end
    end
  end
end