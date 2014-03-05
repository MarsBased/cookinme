# encoding: utf-8

class RecipePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "recipe_photo.png" if original_filename
  end

  # Process files as they are uploaded:
  process :convert => 'png'

  version :large do
    process :resize_to_fill => [421, 298]
  end

  version :thumb do
    process :resize_to_fill => [206, 206]
  end

  def resize value
    manipulate! do |img|
      img = yield(img) if block_given?
      img.resize value
      img
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
