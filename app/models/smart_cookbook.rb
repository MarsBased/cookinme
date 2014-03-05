class SmartCookbook
  include Draper::Decoratable

  def initialize
    self.freeze
  end

  # The name of the image that represents the cover of the smart
  # cookbook.
  # To be implemented by its children
  def cover_image
  end

  # Default class taken by the decorator
  def decorator_class
    CookbookDecorator
  end

  # The recipes of the smart cookbok. Should return an ActiveRecord
  # scope object.
  # To be implemented by its children
  def recipes
  end

  # Same as #recipes but only returning recipes with photos.
  # To be implemented by its children
  def recipes_with_photo
  end

  # The title of the smart cookbook
  # To be implemented by its children
  def title
  end

end
