require 'spec_helper'

describe CookbooksController do

  let(:user) {create(:user)}

  before :each do
    login_user(user)
  end

  describe 'GET #index' do
    before :each do
      @cookbooks = create_list(:cookbook, 3, user: user)
    end

    it "renders the index template" do
      get(:index)
      expect(response).to render_template(:index)
    end

    it "assigns the cookbooks from the logged user to @cookbooks" do
      get(:index)
      expect(assigns(:cookbooks).map(&:model)).to include(*@cookbooks)
    end

    it "assigns decorated cookbooks" do
      get(:index)
      assigns(:cookbooks).each do |cookbook|
        expect(cookbook).to be_decorated
      end
    end

    it "contains a AllRecipesSmartCookbook as the first cookbook assigned" do
      get(:index)
      expect(assigns(:cookbooks).first.model).to be_a(AllRecipesSmartCookbook)
    end

    it "contains a AllRecipesSmartCookbook from the logged user" do
      get(:index)
      expect(assigns(:cookbooks).first.model.user).to eq(user)
    end
  end

  describe 'GET #show' do
    before :each do
      @cookbook = create(:cookbook_with_recipes, user: user)
    end

    it "renders the show template" do
      get(:show, id: @cookbook.id)
      expect(response).to render_template(:show)
    end

    it "decorates the assigned cookbook" do
      get(:show, id: @cookbook.id)
      expect(assigns(:cookbook)).to be_decorated
    end

    it "assigns the requested cookbook to @cookbook" do
      get(:show, id: @cookbook.id)
      expect(assigns(:cookbook)).to eq @cookbook.decorate
    end

    it "assigns the recipes from the cookbook to @recipes" do
      get(:show, id: @cookbook.id)
      expect(assigns(:recipes)).to match_array(@cookbook.recipes.decorate)
    end
  end

  describe 'POST #create' do
    it "creates a new user cookbook cookbook" do
      expect{post(:create)}.to change{user.cookbooks.count}.by(1)
    end

    it "assigns a new decorated cookbook" do
      post(:create)
      expect(assigns(:cookbook)).to be_decorated_with(CookbookDecorator)
    end

    it "assigns an empty array of recipes" do
      post(:create)
      expect(assigns(:recipes)).to eq([])
    end

    it "renders the show template" do
      post(:create)
      expect(response).to render_template(:show)
    end
  end

  describe "PUT #update" do
    it "updates the title of a cookbook" do
      cookbook = create(:cookbook, user: user)
      put(:update, id: cookbook.id, cookbook: {title: 'new title'})
      expect(cookbook.reload.title).to eq('new title')
    end

    it "won't update parameters not permitted" do
      cookbook = create(:cookbook, user: user)
      cookbook_id = cookbook.id
      put(:update, id: cookbook_id, cookbook: {id: cookbook_id+1})
      expect(cookbook.reload.id).to eq(cookbook_id)
    end
  end

  describe "DELETE #destroy" do
    it "removes the cookbook" do
      cookbook = create(:cookbook, user: user)
      expect{delete(:destroy, id: cookbook.id)}.to change{Cookbook.count}.by(-1)
    end

    it "renders nothing with success if cookbook removed" do
      cookbook = create(:cookbook, user: user)
      delete(:destroy, id: cookbook.id)
      expect(response.body).to be_blank
      expect(response).to be_success
    end

    it "fails when the cookbook doesn't belong to the logged user" do
      cookbook = create(:cookbook)
      expect{delete(:destroy, id: cookbook.id)}.
        to raise_error(CanCan::AccessDenied)
    end
  end
end
