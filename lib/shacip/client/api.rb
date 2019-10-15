# frozen_string_literal: true

require 'net/http'

module Shacip
  module Client
    ##
    # Handles Shacip back-end communication
    #
    class Api
      class << self
        def global
          @global ||= Api.new
        end
      end

      attr_accessor :server_url, :api_key

      # Initializes using custom server URL or configuration's one
      def initialize(server_url = nil, api_key = nil)
        self.server_url = server_url || configuration.server_url
        self.api_key = api_key || configuration.api_key
      end

      # Gets URI for a resource
      def resource_uri(*args)
        resource, id = shift_resource(args)
        current = Shacip::Client.configuration.server_url
        until id.nil?
          current = URI.join current, resource, id || ''
          resource, id = shift_resource(args)
        end
        current
      end

      # Headers for an HTTP request
      def headers
        hash = { 'Content-Type': 'application/json' }
        api_key = Shacip::Client.configuration.api_key
        hash['Authorization'] = "ShacipKey #{api_key}" unless api_key.nil?
        hash
      end

      # GET a list of resources from Shacip back-end
      def self.list(*args)
        Api.global.list(*args)
      end

      # POST a JSON hash to Shacip back-end
      def self.post(resource, params)
        Api.global.post(resource, params)
      end

      # GET a JSON resource from Shacip back-end
      def self.get(resource, id)
        Api.global.get(resource, id)
      end

      # PATCH a JSON hash to Shacip back-end
      def self.patch(resource, id, params)
        Api.global.patch(resource, id, params)
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
    end
  end
end
