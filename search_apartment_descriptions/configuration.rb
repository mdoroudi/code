require 'rubygems'
require 'wordnik'

Wordnik.configure do |config|
  config.logger = Logger.new('/dev/null')
  config.api_key = '666d7cd8d6fe7d51ec00701036e073c2b9afabfb28bb95579' 
end
