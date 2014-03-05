# Non ActiveRecord model used to add AllRecipes Smartcookbook
# See SmartCookbook for method explanations

class AllRecipesSmartCookbook < SmartCookbook

  attr_accessor :user

  def initialize user
    @user = user
  end

  def id
    "all-recipes"
  end

  def cover_image
    "cookbook_all-recipes.png"
  end

  def created_at
    Time.now
  end

  def recipes
    user.recipes
  end

  def recipes_with_photo
    recipes.with_photo
  end

  def title
    I18n.t("def.smart_cookbooks.all_recipes")
  end

end