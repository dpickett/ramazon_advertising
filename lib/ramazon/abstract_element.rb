module Ramazon
  module AbstractElement
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def abstract_element(name, type, options = {})
        element(name, type, options.merge(:parser => :abstract_parse, :raw => true))
      end

      def abstract_parse(xml, options = {})
        tag XML::Parser.string(xml).parse.root.name
        parse(xml)
      end
    end
  end
end
