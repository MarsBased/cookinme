require 'spec_helper'

describe CookbookDecorator do
  include Draper::ViewHelpers
  before :each do
    @cookbook = build(:cookbook)
  end

  it "decorates a cookbook" do
    expect(@cookbook.decorate).to be_a(CookbookDecorator)
  end

  it "decorates a smart cookbook" do
    smart_cookbook = AllRecipesSmartCookbook.new(build(:user))
    expect(smart_cookbook.decorate).to be_a(CookbookDecorator)
  end

  describe "#cover_images" do
    it "returns always an array of 4 images" do
      expect(@cookbook.decorate.cover_images).to have(4).things
    end

    it "returns always one image as the cover image of the cookbook" do
      helpers.should_receive(:image_url).with(@cookbook.cover_image).once
      helpers.should_receive(:image_url).at_least(3).times
      @cookbook.decorate.cover_images
    end

    it "returns the cover plus default recipe images if don't have recipes"\
      " with photo" do
      helpers.should_receive(:image_url).once.ordered
      helpers.should_receive(:image_url).
        with('default-recipe-small.png').exactly(3).times.ordered
      @cookbook.decorate.cover_images
    end

    it "returns as many recipe images as the cookbook have." do
      cookbook = build(:cookbook_with_recipes_with_photo, recipes_count: 2)
      helpers.should_receive(:image_url).with(cookbook.cover_image).
        once.ordered.and_return('a')
      helpers.should_receive(:image_url).with('default-recipe-small.png').
        exactly(2).times.ordered.and_return('b', 'c')
      helpers.should_receive(:image_url).with('default-recipe-small.png').
        once.ordered.and_return('d')
      expect(@cookbook.decorate.cover_images).to eq(%w(a b c d))
    end
  end

  describe "#title" do
    it "return the title of the cookbook if has a title" do
      @cookbook.title = 'Food from Barcelona'
      expect(@cookbook.decorate.title).to eq('Food from Barcelona')
    end

    it "return a placeholder if no title is supplied" do
      @cookbook.title = nil
      expect(@cookbook.decorate.title).to eq(I18n.t("def.cookbook.no_title"))
    end
  end

  describe "#is_smart" do
    it "is false if the cookbook is not smart" do
      expect(@cookbook.decorate.is_smart).to be_false
    end

    it "is true when the cookbook is smart" do
      smart_cookbook = AllRecipesSmartCookbook.new(build(:user))
      expect(smart_cookbook.decorate.is_smart).to be_true
    end
  end
end
