module Ramazon
  class Product
    include HappyMapper
    include Ramazon::AbstractElement
    tag 'Item'

    element :asin, String, :tag => 'ASIN'
    element :upc, String, :tag => 'ItemAttributes/UPC'
    element :title, String, :tag => 'Title', :deep => true
    element :product_group, String, :tag => 'ItemAttributes/ProductGroup'
    element :manufacturer, String, :tag => 'ItemAttributes/Manufacturer'
    element :brand, String, :tag => 'ItemAttributes/Brand'
    element :url, String, :tag => 'DetailPageURL'
    abstract_element :small_image, Ramazon::Image, :tag => "SmallImage"
    abstract_element :large_image, Ramazon::Image, :tag => "LargeImage"
    abstract_element :medium_image, Ramazon::Image, :tag => "MediumImage"
    abstract_element :tiny_image, Ramazon::Image, :tag => "TinyImage"
    abstract_element :thumb_image, Ramazon::Image, :tag => "ThumbImage"
    abstract_element :list_price, Ramazon::Price, :tag => "ItemAttributes/ListPrice"
    abstract_element :lowest_new_price, Ramazon::Price, :tag => "OfferSummary/LowestNewPrice"

    element :sales_rank, Integer, :tag => "SalesRank"

    element :new_count, Integer, :tag => "OfferSummary/TotalNew"
    element :used_count, Integer, :tag => "OfferSummary/TotalUsed"
    element :collectible_count, Integer, :tag => "OfferSummary/TotalCollectible"
    element :refurbished_count, Integer, :tag => "OfferSummary/TotalRefurbished"

    element :release_date, Date, :tag => 'ItemAttributes/ReleaseDate'
    element :original_release_date, Date, :tag => 'ItemAttributes/OriginalReleaseDate'

    def self.find(*args)
      options = args.extract_options!
      if options[:item_id]
        item_lookup(options[:item_id], options)
      end
    end

    def self.item_lookup(item_id, options = {})
      req = Ramazon::Request.new({:item_id => item_id, 
        :operation => "ItemLookup"}.merge(options))
      res = req.submit

      Ramazon::ProductCollection.create_from_results(1,1,res)
    end

    def images
      if !@images
        @images = {}
        @images[:thumb] = self.thumb_image if self.thumb_image
        @images[:tiny_image] = self.tiny_image if self.tiny_image
        @images[:small] = self.small_image if self.small_image   
        @images[:medium] = self.medium_image if self.medium_image
        @images[:large] = self.large_image if self.large_image
      end
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
      result = @xml_doc.search(args)
    end

    
  end
end
