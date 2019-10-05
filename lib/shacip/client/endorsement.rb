# frozen_string_literal: true

module Shacip
  module Client
    ##
    # Used to ask Shacip whether it endorses an user credentials
    #
    class Endorsement
      attr_accessor :email, :password
      attr_reader :response

      def initialize(credentials = {}, response = {})
        credentials = credentials&.dup
        @response = response&.dup
        @email = credentials[:email]
        @password = credentials[:password]
      end

      def self.create(credentials)
        response = Api.post(:endorsements, credentials)
        Endorsement.new credentials, response
      end

      def status
        @response&.fetch(:status, nil)
      end

      def recognized
        status == 'recognized'
      end

      def organization
        @response&.fetch(:organization, nil)
      end

      def user
        @response&.fetch(:user, nil)
      end
    end
  end
end
