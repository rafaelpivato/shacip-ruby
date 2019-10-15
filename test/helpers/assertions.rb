# frozen_string_literal: true

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
  end
end
