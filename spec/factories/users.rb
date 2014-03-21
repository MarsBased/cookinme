FactoryGirl.define do
  factory :user do
    username "Guybrush Threepwood"
    sequence(:email) { |n| "guybrush#{n}@example.com"}
    password "logMeIn"

    factory :user_with_avatar do
      avatar {
        fixture_file_upload(
          Rails.root.join('spec', 'fixtures', 'test.jpg'),
          'image/jpg'
        )
      }
    end
  end
end