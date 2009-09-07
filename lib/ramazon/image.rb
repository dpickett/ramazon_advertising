module Ramazon
  # An image object returned by Amazon's product data
  # Available accessors include
  # +url+::
  #   The url of the image
  # +height+::
  #   The height of the image
  # +width+::
  #   The width of the image 
  class Image
    include HappyMapper
    include Ramazon::AbstractElement
    tag "Image"
    element :url, String, :tag => "URL"
    element :height, Integer, :tag => "Height"
    element :width, Integer, :tag => "Width" 
  end
end
