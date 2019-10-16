# frozen_string_literal: true

require 'byebug'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'shacip-client'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
