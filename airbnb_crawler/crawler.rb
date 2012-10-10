require_relative 'property'
require 'debugger'
require 'net/http'
require 'zlib'
require 'json'
require "uri"

class AirbnbCrawler 
  attr_accessor :url
  def initialize(search, check_in, check_out)
    create_search_url(search, check_in, check_out)
  end


  def crawl
    get_search_result(url)
  end
  
  # just hardcoding this for now
  def url
    @url ||= "https://www.airbnb.com/search/ajax_get_results?search_view=1&min_bedrooms=0&min_bathrooms=0&min_beds=0&page=1&location=seattle&checkin=10%2F10%2F2012&checkout=10%2F15%2F2012&guests=1&sort=0&keywords=&per_page=21"
  end


  # check in/out format '10 10 2012'
  # location seattle 
  def create_search_url(location, check_in, check_out)
    check_in = check_in.gsub(" ", "%2F")
    check_out = check_out.gsub(" ", "%2F")
    @url = "https://www.airbnb.com/search/ajax_get_results?search_view"+
      "=1&min_bedrooms=0&min_bathrooms=0&min_beds=0&page=1&location=#{location}"+
      "&checkin=#{check_in}&checkout=#{check_out}&guests=1&sort=0&keywords=&per_page=21"
  end


  def get_search_result(url)
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    
    json_response = JSON.parse(response.body)
    properties = json_response["properties"]
    
    properties_arr = []
    properties.each do |property|
      properties_arr << Property.new(property)
    end
    debugger
    puts "hello"
  end

  def headers
        header_hash = { "User-Agent" =>
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11",
      "Accept" => "application/json, text/javascript, */*; q=0.01",
      "X-Requested-With" => "XMLHttpRequest"
    }
  end


end

bnb_crawler = AirbnbCrawler.new("Seattle")
bnb_crawler.crawl()
