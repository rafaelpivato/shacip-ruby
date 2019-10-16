# frozen_string_literal: true

# require 'codacy-coverage'
# Codacy::Reporter.start

require 'byebug'
require 'minitest'
require 'minitest/assertions'
require 'minitest/autorun'
require 'minitest/mock'
require 'minitest/reporters'
require 'shacip-client'
require 'shacip/client/api'

require_relative 'helpers/assertions'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
