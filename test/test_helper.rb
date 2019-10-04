# frozen_string_literal: true

# require 'codacy-coverage'
# Codacy::Reporter.start

require 'byebug'
require 'minitest'
require 'minitest/autorun'
require 'minitest/fail_fast'
require 'minitest/reporters'
require 'shacip-client'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
