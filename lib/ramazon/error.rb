module Ramazon
  class Error < StandardError
    include HappyMapper
    tag "Error"
    element :code, String, :tag => "Code"
    element :message, String, :tag => "Message"

    def to_s
      "#{self.code}: #{self.message}"
    end
  end
end
