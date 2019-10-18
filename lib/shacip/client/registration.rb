# frozen_string_literal: true

require_relative 'api'
require_relative 'common_resource'
require_relative 'loadable'

module Shacip
  module Client
    ##
    # Starts and confirms registration of users against Shacip
    #
    class Registration < CommonResource
      include Loadable

      data_accessor :email, :password

      def self.confirm(id, app = 'shacip-ruby')
        response = Api.patch(:registrations, id, confirmed: app)
        Registration.new(response)
      end

      def self.create(signup)
        response = Api.post(:registrations, signup)
        Registration.new response
      end

      def accepted
        status == :accepted
      end

      def confirmed
        status == :confirmed
      end

      def organization
        data[:organization]
      end

      def user
        data[:user]
      end
    end
  end
end
