$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rubygems"

require "fileutils"
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
require "ramazon/error"
require "ramazon/request"

require "ramazon/search_bin_parameter"
require "ramazon/search_bin"
require "ramazon/search_bin_set"

require "ramazon/image"
require "ramazon/price"
require "ramazon/merchant"
require "ramazon/offer"

require "ramazon/product"
require "ramazon/product_collection"
require "ramazon/browse_node"

configatron.ramazon.locale = :us
