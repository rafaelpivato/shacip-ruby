# frozen_string_literal: true

require_relative 'api'
require_relative 'common_resource'
require_relative 'loadable'
require_relative 'updatable'

module Shacip
  module Client
    ##
    # Manages an existing organization in Shacip back-end
    #
    class Organization < CommonResource
      include Loadable
      include Updatable

      data_accessor :name, :number

      def self.list(user)
        response = Api.list(user, resource_name)
        organizations = []
        response[:data].each do |payload|
          organizations << Organization.new(payload)
        end
        organizations
      end
    end
  end
end
