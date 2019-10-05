# frozen_string_literal: true

require 'test_helper'

class TestEndorsementIntegration < Minitest::Test
  include Shacip::Client

  def test_create
    response = { status: 'rejected' }
    credentials = { email: 'foo@example.com', password: 'foobar' }
    mock = Minitest::Mock.new.expect :call, response,
                                     [:endorsements, credentials]
    Api.stub :post, mock do
      Endorsement.create(credentials)
    end
    assert mock.verify
  end
end
