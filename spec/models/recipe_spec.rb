# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  cookbook_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  time        :integer
#  guests      :integer
#  difficulty  :string(255)
#

require 'spec_helper'

describe Recipe do
  it { should belong_to(:cookbook) }
  it { should belong_to(:user) }
  it { should have_many(:recipe_photos) }

  it { should ensure_length_of(:title).is_at_most(200) }
  it { should ensure_length_of(:description).is_at_most(2000) }
  it { should validate_presence_of(:user_id) }
  it { should ensure_inclusion_of(:difficulty).in_array(%w(easy medium hard))}
  it { should ensure_inclusion_of(:time).in_array(%w(15' 30' 45' 60' +90'))}
  it { should ensure_inclusion_of(:guests).in_array(%w(2 4 6 +8))}

  it "has a valid factory" do
    expect(build(:recipe)).to(be_valid)
  end

  it "has a valid factory with photos" do
    expect(build(:recipe_with_photos)).to be_valid
  end

  describe ".with_photo" do
    context "when having a recipe with photo and a no photo recipe" do
      before :each do
        @recipe_with_photo = create(:recipe_with_photos)
        @recipe = create(:recipe)
      end

      it "the recipe with photo is returned" do
        expect(Recipe.with_photo).to include(@recipe_with_photo)
      end

      it "the total amount of recipes returned is one" do
        expect(Recipe.with_photo.count).to eq(1)
      end
    end
    context "when having more than one recipe" do
      before :each do
        @older_recipe = create(:recipe_with_photos, created_at: 5.days.ago)
        @recipe = create(:recipe_with_photos, created_at: 1.day.ago)
        @newer_recipe = create(:recipe_with_photos)
      end

      it "returns the recipes in creation order" do
        expect(Recipe.with_photo).to eq([@newer_recipe, @recipe, @older_recipe])
      end
    end
  end

  describe "#has_any_photo" do
    it "returns true if there is at least one photo" do
      recipe = create(:recipe_with_photos, photo_count: 1)
      expect(recipe.has_any_photo).to be_true
    end

    it "returns false if there are no photos" do
      recipe = create(:recipe)
      expect(recipe.has_any_photo).to be_false
    end

  end

  describe "#main_photo" do
    it "returns nil when there are no photos" do
      recipe = create(:recipe)
      expect(recipe.main_photo).to be_nil
    end

    it "returns the first photo when there is at least one photo" do
      recipe = create(:recipe_with_photos)
      expect(recipe.main_photo.url).to eq(recipe.recipe_photos.first.photo_url)
    end
  end

  describe "#create_or_update_photo!" do
    before :each do
      @photo = fixture_file_upload('test.jpg', 'image/jpg')
    end

    context "when the photo has no photos" do
      it "creates a new photo" do
        recipe = create(:recipe)
        recipe.create_or_update_photo!(@photo)
        expect(recipe.recipe_photos.count).to eq(1)
      end
    end
    context "when the photo has one or more photos" do
      before :each do
        @recipe = create(:recipe_with_photos, photo_count: 1)
        @old_photo = @recipe.recipe_photos.first.photo
        @recipe.create_or_update_photo!(@photo)
      end
      it "mantains the same number of photos after update" do
        expect(@recipe.recipe_photos.count).to eq(1)
      end

      it "updates the photo overriding the oldest one" do
        expect(@recipe.recipe_photos.first.photo).to_not eq(@old_photo)
      end
    end
  end
end
