# frozen_string_literal: true

require_relative 'common_resource'
require_relative 'loadable'
require_relative 'updatable'

module Shacip
  module Client
    ##
    # Manages an existing user in Shacip back-end
    #
    class User < CommonResource
      include Loadable
      include Updatable

      data_accessor :email, :name, :nickname

      def self.list(organization)
        response = Api.list(organization)
        users = []
        response[:data].each do |payload|
          users << User.new(payload)
        end
        users
      end
    end
  end
end
