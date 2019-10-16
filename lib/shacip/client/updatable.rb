# frozen_string_literal: true

module Shacip
  module Client
    ##
    # To be included by resources instances that can be updated
    #
    module Updatable
      def self.included(base)
        base.include InstanceMethods
      end

      module InstanceMethods # :nodoc:
        def initialize(*args)
          @updated_fields = {}
          super(*args)
        end

        def update_data(field, value)
          @updated_fields[field] = value
          super(field, value)
        end

        def update
          response = Api.patch(self.class.resource_name, id, @updated_fields)
          @updated_fields = {}
          self.response = response
        end
      end
    end
  end
end
