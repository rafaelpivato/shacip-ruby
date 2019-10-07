# frozen_string_literal: true

require_relative 'common_resource'
require_relative 'resource_loadable'

module Shacip
  module Client
    ##
    # Manages an existing organization in Shacip back-end
    #
    class Organization < CommonResource
      include ResourceLoadable

      data_accessor :name, :number
    end
  end
end
