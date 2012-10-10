require 'nokogiri'
require 'open-uri'
require 'debugger'
require 'net/http'
require "uri"

class AirbnbCrawler 
  attr_accessor :search_string
  def initialize(search)
    @search_string = search
  end


  def crawl
    get_search_result(url)
  end
  
  def url
    #"https://www.airbnb.com/s/#{@search_string}"
    #"http://www.airbnb.com/s/Seattle--WA?checkin=10%2F11%2F2012&checkout=10%2F14%2F2012"
    "http://www.airbnb.com/search/ajax_get_results?search_view=1&min_bedrooms=0&min_bathrooms=0&min_beds=0&page=1&location=seattle&checkin=10%2F10%2F2012&checkout=10%2F15%2F2012&guests=1&sort=0&keywords=&per_page=21"
  end

  def url2
    #"http://www.airbnb.com/s/#{@search_string}"
    "https://www.airbnb.com/s/Seattle--WA?checkin=10%2F11%2F2012&checkout=10%2F14%2F2012"
  end

  def get_search_result(url)
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field "user-agent","mozilla/5.0 (macintosh; intel mac os x 10_6_8) applewebkit/536.11 (khtml, like gecko) chrome/20.0.1132.57 safari/536.11"
    request.add_field "accept", "application/json, text/javascript, */*; q=0.01"
    request.add_field "x-requested-with", "xmlhttprequest"

    debugger
    response = http.request(request)
    response.body
    response.status
    response["header-here"] # All headers are lowercase
      
    #http.start do |http|
      #debugger
      #http.request(req)
    #end

    #res2 = Net::HTTP.new(uri2.host, uri2.port).start do |http|
      #debugger
      #http.request(req2)
    #end
    
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
