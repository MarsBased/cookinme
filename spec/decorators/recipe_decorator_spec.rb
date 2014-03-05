require 'spec_helper'

describe RecipeDecorator do
  include Draper::ViewHelpers


  it "decorates a recipe" do
    recipe = create(:recipe)
    expect(recipe.decorate).to be_a(RecipeDecorator)
  end

  describe "#main_photo_url" do
    it "returns a default image if the recipe has no images" do
      recipe = create(:recipe)
      image_url = helpers.image_url("default-recipe.png")
      expect(recipe.decorate.main_photo_url).to eq(image_url)
    end

    it "returns the main_photo large url of the image" do
      recipe_with_photos = create(:recipe_with_photos)
      RecipePhotoUploader.any_instance.stub(large: double(url: 'picture.jpg'))
      expect(recipe_with_photos.decorate.main_photo_url).
        to eq('picture.jpg')
    end
  end

  describe "#main_photo_url_small" do
    it "returns a default image if the recipe has no images" do
      recipe = create(:recipe)
      image_url = helpers.image_url("default-recipe-small.png")
      expect(recipe.decorate.main_photo_url_small).to eq(image_url)
    end

    it "returns the main_photo thumbnail url of the image" do
      recipe_with_photos = create(:recipe_with_photos)
      RecipePhotoUploader.any_instance.stub(thumb: double(url: 'picture.jpg'))
      expect(recipe_with_photos.decorate.main_photo_url_small).
        to eq('picture.jpg')
    end
  end

  describe "#title" do
    before :each do
      @recipe = build(:recipe)
    end

    it "return the title of the cookbook if has a title" do
      @recipe.title = 'Pizza'
      expect(@recipe.decorate.title).to eq('Pizza')
    end

    it "return a placeholder if no title is supplied" do
      @recipe.title = nil
      expect(@recipe.decorate.title).to eq(I18n.t("def.recipe.no_title"))
    end
  end
end