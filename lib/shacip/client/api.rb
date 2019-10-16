# frozen_string_literal: true

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

      attr_reader :server_url, :api_key

      # Initializes using custom server URL or configuration's one
      def initialize(server_url = nil, api_key = nil)
        config = Shacip::Client.configuration
        @server_url = server_url || config.server_url
        @api_key = api_key || config.api_key
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
        request = Net::HTTP.new server_url
        response = request.get resource_path(*args), headers
        JSON.parse(response.read_body, symbolize_names: true) if response.value
      end

      def post(resource, params)
        request = Net::HTTP.new server_url
        response = request.post resource_path(resource), params, headers
        JSON.parse(response.read_body, symbolize_names: true) if response.value
      end

      def get(resource, id)
        request = Net::HTTP.new server_url
        response = request.get resource_path(resource, id), headers
        JSON.parse(response.read_body, symbolize_names: true) if response.value
      end

      def patch(resource, id, params)
        request = Net::HTTP.new server_url
        response = request.patch resource_path(resource, id), params, headers
        JSON.parse(response.read_body, symbolize_names: true) if response.value
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
