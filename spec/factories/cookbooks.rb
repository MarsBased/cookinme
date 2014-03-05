FactoryGirl.define do
  factory :cookbook do
    title "My cookbook from Barcelona"
    user

    factory :cookbook_with_recipes do
      ignore do
        recipes_count 2
      end
      after(:create) do |cookbook, evaluator|
        FactoryGirl.create_list(:recipe, evaluator.recipes_count, cookbook: cookbook,
          user: cookbook.user)
      end
    end

    factory :cookbook_with_recipes_with_photo do
      ignore do
        recipes_count 2
      end
      after(:create) do |cookbook, evaluator|
        FactoryGirl.create_list(:recipe_with_photos, evaluator.recipes_count,
          cookbook: cookbook, user: cookbook.user)
      end
    end
  end
end