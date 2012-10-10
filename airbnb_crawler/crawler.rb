require 'nokogiri'
require 'open-uri'
require 'debugger'
require 'colorize'
#$LOAD_PATH << '.'

class AirbnbCrawler 
  attr_accessor :search_string
  def initialize()
    @search_string = ""
  end


  
  def url
    "http://airbnb.com/#{@search_string}" 
  end


  def get_search_result(url)
    sleep rand(1.0..2.0)
    header_hash = { "User-Agent" => 
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11",
      "Accept" => "application/json, text/javascript, */*; q=0.01",
      "X-Requested-With" => "XMLHttpRequest"
    }
    Nokogiri::HTML(open(url, header_hash)) 
  end

end

