module Ramazon
  class SearchBin
    include HappyMapper

    tag "Bin"

    has_many :parameters, Ramazon::SearchBinParameter, :tag => "BinParameter"
    element :item_count, Integer, :tag => "BinItemCount"
    element :name, String, :tag => "BinName"
  end
end
