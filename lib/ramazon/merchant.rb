module Ramazon
  # Merchant Details
  # Current supports the following accessors
  # +merchant_id+::
  #   The id of the merchant
  # +glance_page_url+::
  #   The url of the merchant
  # +average_feedback_rating+::
  #   Average Feedback Rating
  # +total_feedback+::
  #   Total Feedback
  class Merchant
    include HappyMapper
    tag "Merchant"

    element :merchant_id, String, :tag => "MerchantId"
    element :glance_page_url, String, :tag => "GlancePage"
    element :average_feedback_rating, Float, :tag => "AverageFeedbackRating"
    element :total_feedback, Integer, :tag => "TotalFeedback"
  end
end
