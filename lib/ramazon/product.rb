module Ramazon
  class Product
    def self.find(*args)
      options = args.extract_options!
      if options[:item_id]
        item_lookup(options[:item_id], options)
      end
    end

    def self.item_lookup(item_id, options = {})
      req = Ramazon::Request.new({:item_id => item_id, 
        :operation => "ItemLookup"}.merge(options))
      resp = req.submit
      resp.products
    end
  end
end
