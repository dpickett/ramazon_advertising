module Ramazon
  # A price object returned by Amazon's product data
  # Available accessors include
  # +amount+::
  #   The unformatted ammount of the price
  # +currency_code+::
  #   The currency of the offer
  # +formatted_price+::
  #   The formatted price of the offer
  class Price
    include HappyMapper
    include Ramazon::AbstractElement

    element :amount, String, :tag => "Amount"
    element :currency_code, String, :tag => "CurrencyCode"
    element :formatted_price, String, :tag => "FormattedPrice"
  end
end
