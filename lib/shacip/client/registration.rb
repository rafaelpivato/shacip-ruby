# frozen_string_literal: true

module Shacip
  module Client
    ##
    # Starts and confirms registration of users against Shacip
    #
    class Registration
      attr_accessor :email, :password
      attr_reader :response

      def initialize(credentials = {})
        credentials = credentials&.dup
        @response = {}
        @email = credentials[:email]
        @password = credentials[:password]
      end

      def status
        @response&.fetch(:status, nil)
      end

      def accepted
        status == 'confirmed'
      end

      def confirmed
        status == 'confirmed'
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
