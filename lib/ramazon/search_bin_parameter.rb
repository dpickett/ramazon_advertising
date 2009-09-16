module Ramazon
  class SearchBinParameter
    include HappyMapper
    tag "BinParameter"

    element :name, String, :tag => "Name"
    element :value, String, :tag => "Value"
  end
end
