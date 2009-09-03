$LOAD_PATH.unshift(File.join(File.dirname(__FILE__) + '..', '..', 'lib'))
require 'ramazon_advertising'

require 'spec/expectations'

configatron.ramazon.configure_from_yaml(File.join(File.dirname(__FILE__), "ramazon_advertising.yml"))

