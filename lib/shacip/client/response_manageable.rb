# frozen_string_literal: true

module Shacip
  module Client
    ##
    # Module to be included in order to manage API response data
    #
    module ResponseManageable
      ##
      # Gets current response data Hash
      #
      # As opposed to `response` this will never return nil. If no data exists
      # or no response exists either, it will return an empty Hash.
      #
      def data
        @response&.fetch(:data, nil) || {}
      end

      ##
      # Assigns new data object to the response
      #
      # This will completely replace existing response object if any. So, if
      # you have errors or some meta information besides data, those will be
      # replaced.
      #
      def data=(value)
        raise ArgumentError, 'Data is not Hash' unless value.is_a? Hash

        @response = { data: value.dup }
      end

      # Gets current response or nil
      def response
        @response
      end

      # Assigns a response Hash with at least one :data property
      def response=(value)
        raise ArgumentError, 'Response is not Hash' unless value.is_a? Hash

        @response = value.dup
      end

      ##
      # Assign response if value has `data` or data itself otherwise
      #
      def response_or_data=(value)
        raise ArgumentError, 'Value is not Hash' unless value.is_a? Hash

        if value.include?(:data)
          self.response = value
        else
          self.data = value
        end
      end

      # Gets status for current response as a symbol
      def status
        @response&.dig(:data, :status)&.to_sym
      end
    end
  end
end
