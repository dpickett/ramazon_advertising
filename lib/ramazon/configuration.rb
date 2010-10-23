module Ramazon
  # the class that persists configuration information for Amazon requests
  class Configuration
    class << self
      LOCALES = [:ca, :de, :fr, :jp, :uk, :us]

      # set the locale for future requests
      # will raise an exception if the locale isn't in the Configuration::LOCALES collection
      def locale=(locale)
        if LOCALES.include?(locale)
          configatron.ramazon.locale = locale
        else
          raise "unknown locale"
        end
      end

      # get the current locale (defaults to the us)
      def locale
        configatron.ramazon.locale || :us
      end

      # get the current access key
      def access_key
        configatron.ramazon.access_key
      end

      # set the current access key
      # @param key [String] access key you're using to access the advertising api
      def access_key=(key)
        configatron.ramazon.access_key = key
      end

      # get the current secret key that is used for request signing
      def secret_key
        configatron.ramazon.secret_key
      end

      # set the secret key so that requests can be appropriately signed
      # @param key [String] secret key you're using to sign advertising requests
      def secret_key=(key)
        configatron.ramazon.secret_key = key
      end

      # get the correct host based on your locale
      def base_uri
        case locale
        when :us
          "http://ecs.amazonaws.com"
        when :uk
          "http://ecs.amazonaws.co.uk"
        else
          "http://ecs.amazonaws.#{locale}"
        end
      end

      # get the full path including locale specific host and /onca/xml path
      def uri
        "#{base_uri}#{path}"
      end

      # get the path where requests should be dispatched to
      def path
        "/onca/xml"
      end

      
    end
  end
end
