class CookbookDecorator < Draper::Decorator
  delegate_all

  PHOTOS_PER_COVER = 3

  # Generates the cover mosaic for a cookbook
  def cover_images
    result = [h.image_url(cover_image)]
    num_photos = put_recipe_images_into(result)
    put_empty_images_into(result, PHOTOS_PER_COVER-num_photos)
    result
  end

  # Retrieves either the title of the cookbook or a text from a new one.
  def title
    source.title || I18n.t("def.cookbook.no_title")
  end

  def is_smart
    object.class.ancestors.include? SmartCookbook
  end

  private

    # Put images from the recipes into the cover mosaic buffer
    def put_recipe_images_into result
      recipes_with_photo.limit(PHOTOS_PER_COVER).each do |recipe|
        result << h.image_url(recipe.main_photo.thumb.url)
      end
      recipes_with_photo.size
    end

    # Put the number of empty recipe images in the
    # cover mosaic buffer stated in the parameter.
    def put_empty_images_into result, num_empty_recipes
      num_empty_recipes.times do
        result << h.image_url("default-recipe-small.png")
      end
    end
end
