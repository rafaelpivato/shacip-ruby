# frozen_string_literal: true

module Shacip
  module Client
    ##
    # Base class for Shacip resources at client side
    #
    class Resource
      def initialize(response_or_data = {})
        self.response_or_data = response_or_data
      end

      # Get current resource name based on class name
      def self.resource_name
        (name.scan(/\w+/).last.downcase + 's').to_sym
      end

      # Gets current response or nil
      def response
        @response&.deep_dup
      end

      # Assigns a response Hash with at least one :data property
      def response=(value)
        raise ArgumentError, 'Response is not Hash' unless value.is_a? Hash

        @response = value.dup
      end
    end
  end
end
