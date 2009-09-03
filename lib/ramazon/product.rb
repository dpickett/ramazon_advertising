module Ramazon
  class Product
    include HappyMapper
    tag 'Item'

    element :asin, String, :tag => 'ASIN'
    element :title, String, :tag => 'Title', :deep => true
    element :manufacturer, String, :tag => 'Manufacturer', :deep => true
    element :url, String, :tag => 'DetailPageURL'

    def self.find(*args)
      options = args.extract_options!
      if options[:item_id]
        item_lookup(options[:item_id], options)
      end
    end

    def self.item_lookup(item_id, options = {})
      req = Ramazon::Request.new({:item_id => item_id, 
        :operation => "ItemLookup"}.merge(options))
      Ramazon::ProductCollection.create_from_results(1,1,req.submit)
    end

    attr_accessor :xml_doc
    def self.sparse(xml, options = {})
      node = XML::Parser.string(xml).parse.root
      node.find("//Item").collect do |n|
        p = parse(xml)
        p.xml_doc = Nokogiri::XML.parse(xml)
        p
      end
    end

    def get(*args)
      @xml_doc.search(args)
    end

    
  end
end
