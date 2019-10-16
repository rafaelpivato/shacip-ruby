# frozen_string_literal: true

require 'json'
require 'net/http'

module Shacip
  module Client
    ##
    # Handles Shacip back-end communication
    #
    class Api
      class << self
        # GET a list of resources from Shacip back-end
        def list(*args)
          Api.new.list(*args)
        end

        # POST a JSON hash to Shacip back-end
        def post(resource, params)
          Api.new.post(resource, params)
        end

        # GET a JSON resource from Shacip back-end
        def get(resource, id)
          Api.new.get(resource, id)
        end

        # PATCH a JSON hash to Shacip back-end
        def patch(resource, id, params)
          Api.new.patch(resource, id, params)
        end
      end

      attr_reader :api_key, :http, :server_uri

      # Initializes using custom server URL or configuration's one
      def initialize(server_uri = nil, api_key = nil)
        config = Shacip::Client.configuration
        @server_uri = URI.parse(server_uri&.to_s || config.server_uri.to_s)
        @api_key = api_key || config.api_key
        @http = Net::HTTP.new(@server_uri.host, @server_uri.port)
      end

      # Gets full URI for a resource
      def resource_uri(*args)
        URI.join server_uri, resource_path(*args)
      end

      # Gets URI path for a resource
      def resource_path(*args)
        segments = []
        segments.append(shift_segment!(args)) until args.empty?
        segments.flatten.compact.join '/'
      end

      # Headers for an HTTP request
      def headers
        hash = {}
        hash['Content-Type'] = 'application/json'
        hash['Authorization'] = "ShacipKey #{api_key}" unless api_key.nil?
        hash
      end

      def list(*args)
        send_request('GET', *args)
      end

      def post(resource, params)
        send_request('POST', resource, params: params)
      end

      def get(resource, id)
        send_request('GET', resource, id)
      end

      def patch(resource, id, params)
        send_request('PATCH', resource, id, params: params)
      end

      def send_request(name, *args, params: nil)
        path = resource_uri(*args)
        data = params&.to_json
        response = http.send_request(name, path, data, headers)
        JSON.parse(response.body, symbolize_names: true) unless response.value
      end

      private

      def shift_segment!(args)
        resource = args.shift
        if resource.is_a? Resource
          [resource.resource_name, resource.id]
        else
          [resource, args.shift]
        end
      end
    end
  end
end
