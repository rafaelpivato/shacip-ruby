# frozen_string_literal: true

require_relative 'data_resource'

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
    class CommonResource < DataResource
      # Gets status for current response as a symbol
      def status
        data[:status]&.to_sym
      end

      # Get id for current response
      def id
        data[:id]
      end
    end
  end
end
