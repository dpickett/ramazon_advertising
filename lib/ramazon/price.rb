module Ramazon
  class Price
    include HappyMapper
    include Ramazon::AbstractElement

    element :amount, String, :tag => "Amount"
    element :currency_code, String, :tag => "CurrencyCode"
    element :formatted_price, String, :tag => "FormattedPrice"
  end
end
