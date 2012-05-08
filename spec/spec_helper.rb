$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'logo_grabber'
require 'vcr'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  VCR.config do |c|
    c.cassette_library_dir = 'fixtures/vcr_cassettes'
    c.stub_with :fakeweb
    c.ignore_localhost = true
  end
end
