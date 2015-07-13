require 'vcr'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

VCR.configure do |c|
    c.hook_into :webmock
    c.cassette_library_dir = 'spec/support/vcr_cassettes'
    c.configure_rspec_metadata!
    c.default_cassette_options = {record: :new_episodes}
end
