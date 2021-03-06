module Ramazon
  # Find and get product details with this class
  # Currently supports the following accessors 
  # (all other elements can be accessed via nokogiri selectors and the get method)
  # +asin+::
  #   Amazon Identifier
  # +upc+::
  #   UPC ID
  # +title+::
  #   Title of the product
  # +product_group+::
  #   The category/product_group of the product
  # +manufacturer+::
  #   The manufacturer of the product
  # +brand+::
  #   The brand of the product
  # +url+::
  #   The Amazon URL of the product
  # +small_image+::
  #   The small image that Amazon provides (NOTE: Returns Ramazon::Image object)
  # +medium_image+::
  #   The medium image that Amazon provides (NOTE: Returns Ramazon::Image object)
  # +large_image+::
  #   The large image that Amazon provides (NOTE: Returns Ramazon::Image object)
  # +list_price+::
  #   The list price of the item (NOTE: Returns Ramazon::Price object)
  # +lowest_new_price+::
  #   The lowest new price from the offer summary (NOTE: Returns Ramazon::Price object)
  # +sales_rank+::
  #   The sales rank of the product
  # +new_count+::
  #   The quantity of new item offers
  # +used_count+::
  #   The quantity of used item offers
  # +collectible_count+::
  #   The quantity of collectible item offers
  # +refurbished_count+::
  #   The quantity of refurbished item offers
  # +release_date+::
  #   The release date of the product
  # +original_release_date+::
  #   The original release date of the product
  # +offers+::
  #   The collection of offers available for the given product
  # @example find an individual item
  #   @products = Ramazon::Product.find(:item_id => "B000NU2CY4", :response_group => "Medium")
  #   @products[0].title
  #   @products[0].asin
  #   @products[0].upc
  #   @products[0].large_image.url
  #   @products[0].url
  #

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
    has_many :offers, Ramazon::Offer, :tag => "Offers/Offer"

    element :sales_rank, Integer, :tag => "SalesRank"

    element :new_count, Integer, :tag => "OfferSummary/TotalNew"
    element :used_count, Integer, :tag => "OfferSummary/TotalUsed"
    element :collectible_count, Integer, :tag => "OfferSummary/TotalCollectible"
    element :refurbished_count, Integer, :tag => "OfferSummary/TotalRefurbished"

    element :release_date, Date, :tag => 'ItemAttributes/ReleaseDate'
    element :original_release_date, Date, :tag => 'ItemAttributes/OriginalReleaseDate'

    attr_accessor :has_first_page_of_full_offers

    # Creates the worker that performs the delta indexing
    # @param options Amazon request options (you can use an underscore convention) 
    # (ie. passing the :response_group option will be converted to "ResponseGroup")
    # <tt>:item_id</tt> - the ASIN or UPC you're looking for
    # @return [Array] array of Ramazon::Product objects
    def self.find(*args)
      options = args.extract_options!
      if options[:item_id]
        item_lookup(options[:item_id], options)
      else
        options[:operation] ||= "ItemSearch"
        options[:search_index] ||= "Blended"
        options[:item_page] ||= 1
        res = Ramazon::Request.new(options).submit
        products = Ramazon::ProductCollection.create_from_results(options[:item_page] || 1, 10, res)
        if find_options_retrieve_all_offers?(options)
          products.each do |p|
            p.has_first_page_of_full_offers = true
            p.offer_pages = offer_pages_for(p)
          end
        end
        products
      end
    end
 
    # Performs an item lookup
    # @param item_id the ASIN or UPC you're looking for
    # @options additional Amazon request options (i.e. :response_group)
    def self.item_lookup(item_id, options = {})
      req = Ramazon::Request.new({:item_id => item_id, 
        :operation => "ItemLookup"}.merge(options))
      res = req.submit

      Ramazon::ProductCollection.create_from_results(1,1,res)
    end

    # assembles the available images for the object
    # @return [Hash] hash of symbolized image_name => Ramazon::Image pairs
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
    def self.parse(xml, options = {})
      node = XML::Parser.string(xml.to_s).parse.root
      node.find("//Item").collect do |n|
        p = super(n.to_s)
        p.xml_doc = Nokogiri::XML.parse(n.to_s)
        p
      end
    end

    # perform a nokogiri search on the product's XML
    # @param args Passes directly to a Nokogiri::Xml.parse(xml).search method
    # @example find the actor
    #   @product = Ramazon::Product.find(:item_id => "B000NU2CY4", :response_group => "Medium")[0]
    #   @product.get("ItemAttributes Actor").collect{|a| a.content}
    def get(*args)
      result = @xml_doc.search(args)
    end

    # returns a hash of category browse nodes from the top down
    def category_tree
      @category_tree = {}
      get_category_browse_nodes.each do |n|
        build_category_tree(n)
      end
      @category_tree
    end

    # a sorted list of used offers
    def used_offers
      if @used_offers.nil?
        @used_offers = []
        self.offers.each do |o|
          if o.condition.downcase == "used"
            @used_offers << o
          end
        end
        @used_offers.sort!{|a,b| a.price.amount <=> b.price.amount}
      end
      @used_offers
    end

    # breaks down all the offers in a nested hash of [condition][subcondition]
    # note: this will load ALL offers into memory
    # @return [Hash] a nest hash of offers [condition][subcondition] => Array of Ramazon::Offer objects
    def offers_by_condition
      @offer_hash = {}
      offer_page = 1
      
      offers = offer_page(offer_page)
      while offer_page <= offer_pages
        offers.each do |o|
          @offer_hash[o.condition.downcase] ||= {}
          @offer_hash[o.condition.downcase][o.sub_condition] ||= []
          @offer_hash[o.condition.downcase][o.sub_condition] << o
        end

        offer_page += 1
        offers = offer_page(offer_page)
      end

      @offer_hash
    end

    # gets the number of offer pages for the specified product
    # @param [Ramazon::Product] product the we want to get offer pages for
    # @returns [Integer] number of offer pages
    def self.offer_pages_for(product)
      if !@offer_pages 
        offer_page_tags = product.get("//Offers/TotalOfferPages")
        if offer_page_tags.size > 0
          offer_pages = offer_page_tags[0].content.to_i
        else
          offer_pages = 1
        end
      end

      offer_pages
    end

    # get the lowest offers broken down by subcondition
    # @return [Hash] a nested hash of prices ie ["new"]["mint"] => Ramazon::Offer
    def lowest_offers
      if @lowest_offers.nil?
        @lowest_offers = {}
        offers_by_condition.each do |condition, sub_conditions|
          @lowest_offers[condition] = {}
          sub_conditions.each do |sub_condition, col|
            sorted_offers = col.sort{|a,b| a.price.amount.to_i <=> b.price.amount.to_i}
            @lowest_offers[condition][sub_condition] = sorted_offers.first
          end
        end
      end

      @lowest_offers
    end

    def offer_pages=(pages)
      @offer_pages = pages.to_i
    end

    def offer_pages
      @offer_pages
    end

    #get offers from a given page
    # @param page [Integer] the page number you want to get
    # @return [Array] Array of Offers returned from the page
    def offer_page(page = 1)
      #get all offers
      if page == 1 && has_first_page_of_full_offers
        self.offers 
      else
        products = self.class.find(:item_id => self.asin, 
          :response_group => "OfferListings",
          :merchant_id => "All",
          :condition => "All",
          :offer_page => page)

        if products
          product = products[0] 
          self.offer_pages = self.class.offer_pages_for(product)
          product.offers
        else
          []
        end
      end
    end

    private
    # recursive function used to generate a topdown category tree
    def build_category_tree(n, child = nil)
      amz_node = BrowseNode.parse(n.to_s)
      amz_node.child = child unless child.nil?

      if n.search("./IsCategoryRoot").size > 0
        @category_tree[amz_node.name] ||= []
        @category_tree[amz_node.name] << amz_node
      else
        parents = n.search("./Ancestors/BrowseNode")
        if parents.size > 0
          build_category_tree(parents[0], amz_node)
        end
      end


    end

    def get_category_browse_nodes
      self.get("BrowseNodes BrowseNode IsCategoryRoot").collect do |n|
        n.ancestors("//BrowseNodes/BrowseNode")
      end
    end

    def self.find_options_retrieve_all_offers?(options = {})
      if options[:response_group].is_a?(Array)
        groups = options[:response_group].join(" ")
      else
        groups = options[:response_group] || ""
      end

      groups =~ /OfferListings/ && 
        (options[:offer_page].nil? || options[:offer_page].to_i == 1) &&
        (options[:merchant_id] == "All") &&
        (options[:condition] == "All")
    end
  end
end
