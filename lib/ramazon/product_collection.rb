module Ramazon
  class ProductCollection < WillPaginate::Collection
    include HappyMapper
 
    def self.create_from_results(page, per_page, body)
      results = Items.parse(body, {})[0]
      debugger
      col = create(page, per_page, results.total_results || 0) do |pager|
        pager.replace(results.products)
      end
      col
    end
    
  end

  class Items
    include HappyMapper
    tag 'Items' 

    element :total_results, Integer, :tag => 'TotalResults'
    element :total_pages, Integer, :tag => 'TotalPages'
    element :products, Ramazon::Product, :tag => "Item", :parser => :sparse, :raw => true
  end
end
