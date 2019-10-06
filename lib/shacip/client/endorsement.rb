# frozen_string_literal: true

require_relative 'response_manageable'

module Shacip
  module Client
    ##
    # Used to ask Shacip whether it endorses an user credentials
    #
    class Endorsement
      include ResponseManageable

      attr_accessor :email, :password
      attr_reader :response

      def initialize(response_or_data = {})
        self.response_or_data = response_or_data
        @email = data[:email]
        @password = data[:password]
      end

      def self.create(credentials)
        response = Api.post(:endorsements, credentials)
        Endorsement.new response
      end

      def recognized
        status == :recognized
      end

      def unknown
        status == :unknown
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
