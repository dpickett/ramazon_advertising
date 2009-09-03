module Ramazon
  class Product
    include HappyMapper
    tag 'Item'

    element :asin, String, :tag => 'ASIN'
    element :title, String, :tag => 'Title'
    element :manufacturer, String, :tag => 'Manufacturer', :deep => true

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

    attr_reader :xml_doc
    def self.parse(xml, options = {})
      @xml_doc = Nokogiri::XML.parse(xml.to_s)
      super
    end

    def get(*args)
      @xml_doc.search(args)
    end

  end
end
