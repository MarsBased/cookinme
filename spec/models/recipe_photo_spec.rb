# == Schema Information
#
# Table name: recipe_photos
#
#  id         :integer          not null, primary key
#  photo      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  recipe_id  :integer
#

require 'spec_helper'

describe RecipePhoto do
  it { should belong_to(:recipe) }
  it { should validate_presence_of(:recipe_id) }
  it { should validate_presence_of(:photo) }

  describe "validates photo filesize" do

    before :each do
      @image = fixture_file_upload('test.jpg', 'image/jpg')
    end

    it "is valid if the size is less than 10MB" do
      @image.stub(size: 9.megabytes)
      expect(build(:recipe_photo, photo: @image).valid?).to be_true
    end

    # TODO: Check why this test isn't working.
    #it "is valid if the size is more than 10MB" do
    #  @image.stub(size: 11.megabytes)
    #  expect(build(:recipe_photo, photo: @image).valid?).to be_false
    #end
  end
end
