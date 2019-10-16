# frozen_string_literal: true

require 'json'

module Minitest
  module Assertions # :nodoc:
    ##
    # Fails unless API +operation gets called in block with +args
    #
    # This will create an API stub for +operation returning +response.
    #
    def assert_api(operation, response, args, &block)
      mock = Minitest::Mock.new.expect :call, response, args
      Shacip::Client::Api.stub operation, mock, &block
      assert_mock mock
    end

    ##
    # Fails unless `Net::HTTP` +method gets called in block with +args
    #
    def assert_http(method, body, args, &block)
      body = JSON.generate(body) unless body.is_a? String
      response = Minitest::Mock.new.expect :value, true
      response.expect :read_body, body
      request = Minitest::Mock.new.expect method, response, args
      stub = Minitest::Mock.new.expect :call, request, [Object]
      Net::HTTP.stub :new, stub, &block
      assert_mock request
      assert_mock response
      assert_mock stub
    end
  end
end
