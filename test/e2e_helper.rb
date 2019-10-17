# frozen_string_literal: true

require 'byebug'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'shacip-client'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class End2EndTest < Minitest::Test
  class << self
    attr_accessor :count, :context, :steps_methods, :steps_names

    def inherited(subclass)
      super(subclass)
      subclass.count = 0
      subclass.context = {}
      subclass.steps_methods = []
      subclass.steps_names = {}
    end

    def test_order
      :alpha
    end

    def step(name, &block)
      method = new_method_name(name)
      if block_given?
        define_method(method, &block)
      else
        define_method(method) do
          flunk "No implementation provided for #{name}"
        end
      end
      steps_methods << method
      steps_names[method] = "#{count}) #{name}"
    end

    def new_method_name(name)
      self.count += 1
      test = format('test_%<order>04d_%<snake>s',
                    order: self.count,
                    snake: name.downcase.gsub(/\s+/, '_')).to_sym
      raise "#{name} is already defined in #{self}" if method_defined? test

      test
    end
  end

  # Human friendly name after it has been used as method name
  def after_teardown
    self.name = self.class.steps_names[name.to_sym]
    super
  end

  # Store set of keys to test class context
  def store_context(hash)
    self.class.context.merge! hash
  end

  # Loads test class context key
  def load_context(key)
    flunk "Cannot find context #{key}" unless self.class.context.include? key
    self.class.context[key]
  end
end
