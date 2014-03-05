include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :recipe_photo do
    recipe
    photo { fixture_file_upload(
              Rails.root.join('spec', 'fixtures', 'test.jpg'),
              'image/jpg'
            )
          }
  end
end