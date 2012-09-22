#require 'simplecov'
#SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/core'

RSpec::configure do |c|
  c.backtrace_clean_patterns << /vendor\//
  c.backtrace_clean_patterns << /lib\/rspec\/rails/
end

require 'rspec/rails/view_rendering'
require 'rspec/rails/adapters'
require 'rspec/rails/matchers'
#require 'rspec/rails/fixture_support'
require 'rspec/rails/mocks'
#require 'rspec/rails/module_inclusion'
require 'rspec/rails/example'
#require 'rspec/rails/vendor/capybara'
#require 'rspec/rails/vendor/webrat'
require 'rspec/autorun'

RSpec.configure do |config|
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
  
  config.include RSpec::Rails::RequestExampleGroup, :type => :request, :example_group => {
    :file_path => /spec\/api/
  }

end
