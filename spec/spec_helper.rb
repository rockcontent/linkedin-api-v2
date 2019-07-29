require "bundler/setup"
require "linkedin_v2"
require "webmock/rspec"
require "pry"
require File.expand_path("./support/vcr", __dir__)
require "coveralls"
Coveralls.wear!

WebMock.disable_net_connect!(allow_localhost: true)
WebMock.allow_net_connect!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.expose_dsl_globally = true
end
