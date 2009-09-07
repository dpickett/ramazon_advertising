$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rubygems"

require "base64"
require "hmac-sha2"
require "digest/sha1"
require "digest/sha2"
require "cgi"

require "will_paginate"
require "httparty"
require "happymapper"
require "nokogiri"
require "configatron"
require "active_support/inflector"

require "ramazon/rails_additions"

require "ramazon/abstract_element"

require "ramazon/signatory"
require "ramazon/configuration"
require "ramazon/request"

require "ramazon/image"
require "ramazon/price"
require "ramazon/product"
require "ramazon/product_collection"

configatron.ramazon.locale = :us
