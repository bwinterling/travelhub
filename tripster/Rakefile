# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Tripster::Application.load_tasks

namespace :test do
  RSpec::Core::RakeTask.new(:rspec)
  Rake::TestTask.new(:minitest)
end
