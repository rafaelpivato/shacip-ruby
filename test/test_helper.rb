# frozen_string_literal: true

# require 'codacy-coverage'
# Codacy::Reporter.start

require 'byebug'
require 'minitest'
require 'minitest/autorun'
require 'minitest/mock'
require 'minitest/reporters'
require 'shacip-client'
require 'shacip/client/api'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
