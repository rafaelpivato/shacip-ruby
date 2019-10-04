# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'rake'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'codacy-coverage', require: false
  gem 'minitest'
  gem 'minitest-ci'
  gem 'rubocop'
end
