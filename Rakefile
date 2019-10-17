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
  t.options = '--ci-report --exclude=/WIP/'
  t.verbose = true
  t.libs << 'test'
end

Rake::TestTask.new do |t|
  t.name = 'test:wip'
  t.description = 'Run WIP tests'
  t.options = '--name=/WIP/ --fail-fast'
  t.libs << 'test'
  t.libs << '.'
end

Rake::TestTask.new do |t|
  t.name = 'test:e2e'
  t.description = 'Run End-to-End tests'
  t.options = '--fail-fast'
  t.pattern = 'test/e2e/test*.rb'
  t.libs << 'test'
  t.libs << '.'
end
