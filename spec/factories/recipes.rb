FactoryGirl.define do
  factory :recipe do
    title "Grog"
    description "kerosene, scumm, rum, acetone, battery acid, pepperoni."
    user
    cookbook

    factory :recipe_with_photos do
      ignore do
        photo_count 2
      end
      after(:create) do |recipe, evaluator|
        FactoryGirl.create_list(
          :recipe_photo,
          evaluator.photo_count,
          recipe: recipe
        )
      end
    end
  end
end