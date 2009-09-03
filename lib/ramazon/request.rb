module Ramazon
  class Request
    include HTTParty
    attr_accessor :options

    def initialize(options = {})
      self.options = options.merge(default_options)
    end

    def submit
      resp = self.class.get(signed_url)
      require "ruby-debug"
      debugger

      resp
    end

    #use this if any type of caching is desired (TBD)
    def unsigned_path
      qs = ""

      sorted_params.each do |key, value|
        qs << "&#{key}=#{URI.encode(value.to_s)}"
      end

      qs.size > 0 ? qs[1..qs.size] : qs
    end

    def signed_url
      self.options[:timestamp] = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S")
      encoded_param_strings = []
      sorted_params.each do |p|
        encoded_param_strings << "#{p[0]}=#{CGI::escape(p[1])}"
      end
      string_to_sign = 
"GET
#{Ramazon::Configuration.base_uri.gsub("http://", "")}
#{Ramazon::Configuration.path}
#{encoded_param_strings.join("&")}"

      signature = Ramazon::Signatory.sign(string_to_sign)
      encoded_param_strings << "Signature=" + signature
      
      "#{Ramazon::Configuration.uri}?#{encoded_param_strings.join("&")}"
    end

    def sorted_params
      params.sort {|a, b| a <=> b}
    end

    def params
      formatted_params = {}
      self.options.each do |key, value|
        formatted_params[key.to_s.classify] = value.is_a?(Array) ? value.join(",") : value
      end

      formatted_params
    end

    private
    def default_options
      {
        :service => "AWSECommerceService",
        :version => "2009-07-01",
        :AWSAccessKeyId => Ramazon::Configuration.access_key
      }
    end

    def service_url
      country = opts.delete(:country)
      country = (country.nil?) ? "us" : country
      url = SERVICE_URLS[country.to_sym]

      raise AmazonAssociate::RequestError, "Invalid country \"#{country}\"" unless url
      url
    end
  end
end
