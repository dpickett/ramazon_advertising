module Ramazon
  class ProductCollection < WillPaginate::Collection
    include HappyMapper
    has_many :search_bin_sets, Ramazon::SearchBinSet, :tag => "SearchBinSets/SearchBinSet"

    def self.create_from_results(page, per_page, body)
      results = Items.parse(body, {})[0]
      col = create(page, 10, results.total_results || 0) do |pager|
        pager.replace(results.products)
      end
      
      col.search_bin_sets = Ramazon::SearchBinSet.parse(body)
      col
    end
    
  end

  class Items
    include HappyMapper
    tag 'Items' 

    element :total_results, Integer, :tag => 'TotalResults'
    element :total_pages, Integer, :tag => 'TotalPages'

    has_many :products, 
      Ramazon::Product,
      :tag => "Item",
      :raw => true
  end
end
