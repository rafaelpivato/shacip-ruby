# frozen_string_literal: true

class Object # :nodoc:
  # Indicates if object can be duplicated
  unless defined? duplicable?
    def duplicable?
      true
    end
  end

  # Deep duplicate an object if possible
  unless defined? deep_dup
    def deep_dup
      duplicable? ? dup : self
    end
  end
end

class Method # :nodoc:
  # Methods are not duplicable
  unless defined? duplicable?
    def duplicable?
      false
    end
  end
end

class UnboundMethod # :nodoc:
  # Unbound methods are not duplicable
  unless defined? duplicable?
    def duplicable?
      false
    end
  end
end

class Array # :nodoc:
  # Returns a deep copy of array.
  unless defined? deep_dup
    def deep_dup
      map ->(item) { item.deep_dup }
    end
  end
end

class Hash # :nodoc:
  # Returns a deep copy of hash.
  unless defined? deep_dup
    def deep_dup
      to_h do |key, value|
        [key.to_sym, value.deep_dup]
      end
    end
  end
end
