# Added quality manipulation to carrierwave
module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

# Carrierwave configuration
CarrierWave.configure do |config|
  case Rails.env
    when 'production'
      config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
        :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
        :region                 => 'eu-west-1'
      }
      config.fog_directory  = 'cookinme'
      config.fog_public     = true
      config.storage        = :fog
    when 'development'
      config.storage = :file
    when 'test'
      config.storage = :file
      config.enable_processing = false
      config.root = "#{Rails.root}/tmp"
  end
end