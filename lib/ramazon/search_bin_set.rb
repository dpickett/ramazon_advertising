module Ramazon
  class SearchBinSet
    include HappyMapper

    tag "SearchBinSet"

    attribute :narrow_by, String, :tag => "NarrowBy"

    has_many :search_bins, Ramazon::SearchBin, :tag => "Bin"
  end
end
