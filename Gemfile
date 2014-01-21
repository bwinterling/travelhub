source 'https://rubygems.org'

ruby "2.0.0"

gem 'rails', '4.0.1'

gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'instagram'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'twitter'
gem 'foursquare2'
gem 'faraday'
gem 'resque', '~> 1.22.0'
gem 'figaro'

group :production do
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', require: false
end

group :production, :development do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
end

group :test do
  gem 'sqlite3'
  gem 'database_cleaner'
  gem "selenium-webdriver"
  gem 'pry'
end

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
end
