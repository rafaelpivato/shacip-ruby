# frozen_string_literal: true

require_relative 'common_resource'
require_relative 'resource_loadable'

module Shacip
  module Client
    ##
    # Manages an existing user in Shacip back-end
    #
    class User < CommonResource
      include ResourceLoadable

      data_accessor :email, :name, :nickname
    end
  end
end
