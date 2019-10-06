# frozen_string_literal: true

module Shacip
  module Client
    ##
    # To be included by resources that can be loaded by id
    #
    module ResourceLoadable
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods # :nodoc:
        def load(id)
          response = Api.get(resource_name, id)
          new response
        end
      end
    end
  end
end
