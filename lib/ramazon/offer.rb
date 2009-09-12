module Ramazon
  # Offer Details
  # Currently supports the following accessors 
  # +merchant+::
  #   The merchant that is listing this product (NOTE: Returns Ramazon::Merchant object)
  # +condition+::
  #   The condition of the product
  # +sub_condition+::
  #   The subcondition of the product
  # +listing_id+::
  #   The id of the listing
  # +price+::
  #   The asking price of the listing (NOTE: Returns Ramazon::Price object)
  class Offer
    include HappyMapper
    include Ramazon::AbstractElement

    tag "Offer"

    has_one :merchant, Ramazon::Merchant, :tag => "Merchant"
    element :condition, String, :tag => "OfferAttributes/Condition"
    element :sub_condition, String, :tag => "OfferAttributes/SubCondition"
    element :listing_id, String, :tag => "OfferListing/OfferListingId"
    abstract_element :price, Ramazon::Price, :tag => "OfferListing/Price"

  end
end
