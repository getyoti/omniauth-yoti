require 'simplecov'
SimpleCov.start
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'omniauth/yoti'
require 'webmock/rspec'

def stub_api_requests_v1
  response = File.read('spec/fixtures/payload_v1.json')
  stub_request(:get, %r{https:\/\/api.yoti.com\/api\/v1\/profile\/(.)*})
    .to_return(
      status: 200,
      body: response,
      headers: { 'Content-Type' => 'application/json' }
    )
end

RSpec.configure do |config|
  config.before(:each) do
    stub_api_requests_v1
  end
end
