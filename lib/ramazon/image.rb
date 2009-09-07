module Ramazon
  class Image
    include HappyMapper
    include Ramazon::AbstractElement
    tag "Image"
    element :url, String, :tag => "URL"
    element :height, Integer, :tag => "Height"
    element :width, Integer, :tag => "Width" 
  end
end
