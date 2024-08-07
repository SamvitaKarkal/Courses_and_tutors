ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'factory_bot_rails'

# Load supporting ruby files from spec/support/ and its subdirectories
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Configure RSpec
RSpec.configure do |config|
  # Configure RSpec to use fixtures
  config.include FactoryBot::Syntax::Methods

  # Infer spec type from file location
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails backtraces
  config.filter_rails_from_backtrace!

  # Additional RSpec configurations can be added here
end
