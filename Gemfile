source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'jcdecaux-client', :git => 'git://github.com/etnlmy/jcdecaux-client.git'
gem 'whenever', :require => false

group :development, :test do
  gem 'sqlite3', '~> 1.3.9'
  gem 'rspec-rails', '2.11.0'
end

group :test do
  gem 'factory_girl_rails', '4.1.0'
end

group :production do
  gem 'mysql2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', '=2.0.0.backport1'
  gem 'sprockets', '=2.2.2.backport2'
  gem 'sass-rails', github: 'guilleiguaran/sass-rails', branch: 'backport'
  gem 'bootstrap-sass', '~> 3.1.1'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'd3_rails'
  gem 'topojson-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '~> 0.10.2'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
