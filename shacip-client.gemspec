# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)
require 'shacip/client/version'

Gem::Specification.new do |s|
  s.name = 'shacip-client'
  s.version = Shacip::Client::VERSION

  s.authors = 'Rafael Pivato'
  s.email = 'rpivato@gmail.com'

  s.homepage = 'https://rubygems.org/gems/shacip-rails'
  s.summary = 'Shacip Ruby Client'
  s.license = 'MIT'

  s.required_ruby_version = '>= 2.6.4'

  s.files = Dir['README.md', 'lib/**/*.rb', 'MIT-LICENSE']
end
