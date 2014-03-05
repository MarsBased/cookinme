require 'spec_helper'

describe AllRecipesSmartCookbook do

  before :each do
    @user = create(:user)
    @all_recipes = AllRecipesSmartCookbook.new(@user)
  end

  it "is a subclass of SmartCookbook" do
    expect(@all_recipes).to be_a_kind_of(SmartCookbook)
  end

  describe "#initialize" do
    it "sets the user to the object" do
      expect(@all_recipes.user).to eq(@user)
    end
  end

  describe "#id" do
    it "always return all-recipes" do
      expect(@all_recipes.id).to eq("all-recipes")
    end
  end

  describe "#cover_image" do
    it "always return cookbook_all-recipes.png" do
      expect(@all_recipes.cover_image).to eq("cookbook_all-recipes.png")
    end
  end

  describe "#created_at" do
    it "returns the current date" do
      @time_now = Time.now
      Time.stub(:now).and_return(@time_now)
      expect(@all_recipes.created_at).to eq(@time_now)
    end
  end

  describe "#recipes" do
    it "retrieves all the recipes from the user" do
      @user.should_receive(:recipes)
      @all_recipes.recipes
    end
  end

  describe "#recipies_with_photo" do
    it "retrieves all the recipes with photo from the user" do
      recipes = double('recipes', with_photo: true)
      recipes.should_receive(:with_photo)
      @user.should_receive(:recipes).and_return(recipes)
      @all_recipes.recipes_with_photo
    end
  end

  describe "#title" do
    it "returns the title of the smart cookbook" do
      all_recipes_title = I18n.t("def.smart_cookbooks.all_recipes")
      expect(@all_recipes.title).to eq(all_recipes_title)
    end
  end

end