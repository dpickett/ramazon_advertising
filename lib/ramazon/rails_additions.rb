#this code courtesy of Pat Allan and Rails Core
module Ramazon
  module HashExcept
    # Returns a new hash without the given keys.
    def except(*keys)
      rejected = Set.new(respond_to?(:convert_key) ? keys.map { |key| convert_key(key) } : keys)
      reject { |key,| rejected.include?(key) }
    end

    # Replaces the hash without only the given keys.
    def except!(*keys)
      replace(except(*keys))
    end
  end
end

Hash.send(
  :include, Ramazon::HashExcept
) unless Hash.instance_methods.include?("except")

module Ramazon
  module ArrayExtractOptions
    def extract_options!
      last.is_a?(::Hash) ? pop : {}
    end
  end
end

Array.send(
  :include, Ramazon::ArrayExtractOptions
) unless Array.instance_methods.include?("extract_options!")

module Ramazon
  module ClassAttributeMethods
    def cattr_reader(*syms)
      syms.flatten.each do |sym|
        next if sym.is_a?(Hash)
        class_eval(<<-EOS, __FILE__, __LINE__)
          unless defined? @@#{sym}
            @@#{sym} = nil
          end

          def self.#{sym}
            @@#{sym}
          end

          def #{sym}
            @@#{sym}
          end
        EOS
      end
    end

    def cattr_writer(*syms)
      options = syms.extract_options!
      syms.flatten.each do |sym|
        class_eval(<<-EOS, __FILE__, __LINE__)
          unless defined? @@#{sym}
            @@#{sym} = nil
          end

          def self.#{sym}=(obj)
            @@#{sym} = obj
          end

          #{"
          def #{sym}=(obj)
            @@#{sym} = obj
          end
          " unless options[:instance_writer] == false }
        EOS
      end
    end

    def cattr_accessor(*syms)
      cattr_reader(*syms)
      cattr_writer(*syms)
    end
  end
end

Class.extend(
  Ramazon::ClassAttributeMethods
) unless Class.respond_to?(:cattr_reader)

module Ramazon
  module MetaClass
    def metaclass
      class << self
        self
      end
    end
  end
end

unless Object.new.respond_to?(:metaclass)
  Object.send(:include, Ramazon::MetaClass)
end

