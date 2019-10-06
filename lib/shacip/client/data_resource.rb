# frozen_string_literal: true

require_relative 'resource'

module Shacip
  module Client
    ##
    # A resource with encapsulated data
    #
    # This base class handles the specific cases for resources containing a
    # common data where all fields will be contained. That is useful when
    # the back-end wants to mix meta-data with actual data.
    #
    # Note that this `data` property will only be seen on responses.
    #
    class DataResource < Resource
      def initialize(response_or_data = {})
        self.response_or_data = response_or_data
      end

      ##
      # Directive for defining payload data accessors
      #
      #   class MyResource < DataResource
      #     data_accessor :greetings
      #   end
      #
      #   res = MyResource.new
      #   res.greetings = 'hello'              # => 'hello'
      #   res.greetings                        # => 'hello'
      #   res.data[:greetings]                 # => 'hello'
      #   res.response.dig(:data, :greetings)  # => 'hello'
      #
      def self.data_accessor(*args)
        args.each do |field|
          fsym = field.to_sym
          define_method(fsym) { data[fsym] }
          define_method("#{field}=".to_sym) { |value| data[fsym] = value }
        end
      end

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

        @response = { data: value.deep_dup }
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
    end
  end
end
