# frozen_string_literal: true

require 'rake/testtask'
require 'minitest'
require 'minitest-ci'

Rake::TestTask.new do |t|
  t.description = 'Run tests'
  t.libs << 'test'
end

Rake::TestTask.new do |t|
  t.name = 'test:ci'
  t.description = 'Run CI tests'
  t.options = '--ci-report'
  t.verbose = true
  t.libs << 'test'
end
