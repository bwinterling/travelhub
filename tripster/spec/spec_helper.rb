ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include SeleniumHelper, :type => :request
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
 
  config.before(:each, js: true) do
    DatabaseCleaner.start
  end
 
  config.after(:each, js: true) do
    DatabaseCleaner.clean
  end

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    :provider => 'twitter',
    :uid => '123545',
    :info => {
      :name => 'rolen' }
  })

  OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
    :provider => 'instagram',
    :uid => '678910',
    :info => {
      :name => 'larry' }
  })

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.include Capybara::DSL
end
