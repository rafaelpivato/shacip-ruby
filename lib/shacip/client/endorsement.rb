# frozen_string_literal: true

require_relative 'common_resource'

module Shacip
  module Client
    ##
    # Used to ask Shacip whether it endorses an user credentials
    #
    class Endorsement < CommonResource
      data_accessor :email, :password

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
