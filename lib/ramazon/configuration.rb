module Ramazon
  class Configuration
    class << self
      LOCALES = [:ca, :de, :fr, :jp, :uk, :us]
      def locale=(locale)
        if LOCALES.include?(locale)
          configatron.ramazon.locale = locale
        else
          raise "unknown locale"
        end
      end

      def locale
        configatron.ramazon.locale 
      end

      def access_key
        configatron.ramazon.access_key
      end

      def access_key=(key)
        configatron.ramazon.access_key = key
      end

      def secret_key
        configatron.ramazon.secret_key
      end

      def secret_key=(key)
        configatron.ramazon.secret_key = key
      end

      def base_uri
        if locale == :us
          "http://ecs.amazonaws.com"
        else
          "http://ecs.amazonaws.#{locale}"
        end
      end

      def uri
        "#{base_uri}#{path}"
      end

      def path
        "/onca/xml"
      end

      
    end
  end
end
