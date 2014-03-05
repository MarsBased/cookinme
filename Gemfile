source 'https://rubygems.org'

gem 'rails', '4.0.3'

# Mysql connector for rails
gem 'mysql2'

gem 'jquery-rails'

# JSON rendering
gem 'rabl-rails',
  git: "https://github.com/yrgoldteeth/rabl-rails.git",
  branch: 'rails4'

# Sprockets assets pipeline for rails
gem 'sprockets-rails', require: 'sprockets/railtie'

# Build JSON APIs with ease.
# Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# Gem to manage autorization
gem 'cancan'

# Access to S3 Amazon Storage
gem 'fog'

# Needed by Fog
gem 'unf'

# Manages file uploads to models
gem 'carrierwave'

# Used by carrierwave to manage image conversion
gem 'mini_magick'

# Adds decorator functionalities to models
gem 'draper'

# Use unicorn as the app server
gem 'unicorn'

# Lightweight authentication for rails
gem 'sorcery'

# Sending emails throught the mandrill api using templates
gem 'mandrill_mailer'

# Twitter bootstrap
gem 'twitter-bootstrap-rails'

# Settings files managing
gem "figaro"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  # To use debugger
  gem 'debugger'
  # Asset message are no longer logged
  gem 'quiet_assets'
  # Document the models
  gem 'annotate'
  # Deploy with Capistrano
  gem 'capistrano', '~>3.0'
  # Rails specific capistrano functions
  gem 'capistrano-rails', '~>1.1.0'
  # Integrate bundler with capistrano
  gem 'capistrano-bundler'
  # Capistrano with rbenv
  gem 'capistrano-rbenv',
    :git => 'https://github.com/capistrano/rbenv.git',
    :ref => '67222bbce120323e422b051dcd167d8e2d3adbf0'

  # Rails preloaderb
  gem 'spring'
  gem "spring-commands-rspec"
end

group :development, :test do
  # Used to test rails applications
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  # Javascript runtime for production enviorenments
  gem 'therubyracer'
end

group :test do
  gem "shoulda-matchers"
  gem "faker"
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem 'capybara-angular'
end
