class RecipeDecorator < Draper::Decorator
  delegate_all

  def main_photo_url
    main_photo.try(:large).try(:url) || h.image_url("default-recipe.png")
  end

  def main_photo_url_small
    main_photo.try(:thumb).try(:url) || h.image_url("default-recipe-small.png")
  end

  def title
    source.title || I18n.t("def.recipe.no_title")
  end
end