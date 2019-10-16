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
      attr_accessor :server_url, :app_name, :api_key

      def initialize
        @server_url = 'http://localhost:3001/'
        @app_name = 'shacip-ruby'
        @api_key = nil
      end
    end
  end
end
