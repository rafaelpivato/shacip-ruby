# frozen_string_literal: true

module Shacip
  module Client
    ##
    # Base class for client errors
    #
    class ClientError < ApplicationError
      def initialize(msg = 'Client Error')
        super
      end
    end
  end
end
