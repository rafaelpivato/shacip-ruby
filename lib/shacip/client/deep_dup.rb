# frozen_string_literal: true

class Object # :nodoc:
  # Indicates if object can be duplicated
  def duplicable?
    true
  end

  # Deep duplicate an object if possible
  def deep_dup
    duplicable? ? dup : self
  end
end

class Method # :nodoc:
  # Methods are not duplicable
  def duplicable?
    false
  end
end

class UnboundMethod # :nodoc:
  # Unbound methods are not duplicable
  def duplicable?
    false
  end
end

class Array # :nodoc:
  # Returns a deep copy of array.
  def deep_dup
    map ->(item) { item.deep_dup }
  end
end

class Hash # :nodoc:
  # Returns a deep copy of hash.
  def deep_dup
    to_h do |key, value|
      [key.to_sym, value.deep_dup]
    end
  end
end
