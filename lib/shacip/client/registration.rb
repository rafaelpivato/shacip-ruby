# frozen_string_literal: true

require_relative 'response_manageable'

module Shacip
  module Client
    ##
    # Starts and confirms registration of users against Shacip
    #
    class Registration
      include ResponseManageable

      def initialize(response_or_data = {})
        self.response_or_data = response_or_data
      end

      def self.confirm(id, app = 'shacip-ruby')
        response = Api.patch(:registrations, id, confirmed: app)
        Registration.new(response)
      end

      def self.create(signup)
        response = Api.post(:registrations, signup)
        Registration.new response
      end

      def accepted
        status == :confirmed
      end

      def confirmed
        status == :confirmed
      end

      def email
        data[:email]
      end

      def password
        data[:password]
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
