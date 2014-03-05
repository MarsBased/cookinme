# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "avatar_photo.png" if original_filename
  end

  def extension_white_list
    # Does not need extension checking if comming from remote url.
    %w(jpg jpeg gif png) if model.remote_avatar_url.blank?
  end

  # Process files as they are uploaded:
  process :resize_to_fill => [120, 120]
  process :convert => 'png'

end
