module Ramazon
  class Signatory
    def self.sign(string_to_sign)
      sha1 = HMAC::SHA256.digest(Ramazon::Configuration.secret_key, string_to_sign)

      #Base64 encoding adds a linefeed to the end of the string so chop the last character!
      CGI.escape(Base64.encode64(sha1).chomp)
    end
  end
end
