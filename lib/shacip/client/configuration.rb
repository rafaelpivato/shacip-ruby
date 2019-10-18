# frozen_string_literal: true

module Shacip
  module Client # :nodoc:
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield configuration
      end

      def reset
        @configuration = Configuration.new
      end
    end

    ##
    # Configuration options for this Shacip client library
    #
    class Configuration
      attr_reader :server_uri, :app_name
      attr_accessor :api_key

      DEFAULT_APP_NAME = 'shacip-ruby'

      def initialize
        self.server_uri = 'http://localhost:3001/'
        self.app_name = DEFAULT_APP_NAME
        @api_key = nil
      end

      def server_uri=(value)
        @server_uri = URI.parse(value.to_s)
      end

      def app_name=(value)
        @app_name = value&.to_s || 'shacip-ruby'
      end
    end
  end
end
