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
        @server_url = server_url || Shacip::Client.configuration.server_url
        @api_key = api_key || Shacip::Client.configuration.api_key
      end

      # Gets URI for a resource
      def resource_uri(*args)
        resource, id = shift_resource(args)
        current = server_url
        until id.nil?
          current = URI.join current, resource, id || ''
          resource, id = shift_resource(args)
        end
        current
      end

      # Headers for an HTTP request
      def headers
        hash = { 'Content-Type': 'application/json' }
        api_key = api_key
        hash['Authorization'] = "ShacipKey #{api_key}" unless api_key.nil?
        hash
      end

      def list(*args)
        response = Net::HTTP.get resource_uri(*args), headers
        JSON.parse(response.read_body) if response.value
      end

      def post(resource, params)
        response = Net::HTTP.post resource_uri(resource), params, headers
        JSON.parse(response.read_body) if response.value
      end

      def get(resource, id)
        response = Net::HTTP.get resource_uri(resource, id), headers
        JSON.parse(response.read_body) if response.value
      end

      def patch(resource, id, params)
        response = Net::HTTP.patch resource_uri(resource, id), params, headers
        JSON.parse(response.read_body) if response.value
      end

      private

      def shift_resource(args)
        resource = args.shift
        if resource.is_a? Resource
          [resource, resource.id]
        else
          [resource, args.shift]
        end
      end
    end
  end
end
