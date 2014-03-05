# == Schema Information
#
# Table name: cookbooks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'spec_helper'

describe Cookbook do
  it { should have_many(:recipes) }
  it { should belong_to(:user) }
  it { should ensure_length_of(:title).is_at_most(200) }
  it { should validate_presence_of(:user_id) }

  it "has a valid factory" do
    expect(build(:cookbook)).to be_valid
  end

  describe "#cover_image" do
    it "is always cookbook.png" do
      expect(build(:cookbook).cover_image).to eq("cookbook.png")
    end
  end

  describe "#recipes_with_photo" do
    before do
      @cookbook = create(:cookbook)
    end

    it "return nil if there are no recipes with photos" do
      create_list(:recipe, 3, cookbook: @cookbook)
      expect(@cookbook.recipes_with_photo).to be_empty
    end

    it "return a recipe if it contains a recipe with photo" do
      create_list(:recipe, 3, cookbook: @cookbook)
      recipe_with_photo = create(:recipe_with_photos, cookbook: @cookbook)
      expect(@cookbook.recipes_with_photo).to include(recipe_with_photo)
    end

    it "return as many recipes with photos as it contains" do
      italian_pasta_cookbook = create(:cookbook)
      create_list(:recipe_with_photos, 3, cookbook: italian_pasta_cookbook)
      create_list(:recipe_with_photos, 2, cookbook: @cookbook)
      expect(@cookbook.recipes_with_photo.count).to eq(2)
    end
  end
end
