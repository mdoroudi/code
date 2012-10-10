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
    "https://www.airbnb.com/s/#{@search_string}"
  end

  def get_search_result(url)
    uri = URI.parse(url)
    #response = Net::HTTP.get_response(uri, headers)
    #Net::HTTP::Get.new(uri, {header: headers})

    debugger
    req = Net::HTTP::Get.new(uri.path)
    req.add_field "User-Agent","Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11"
    req.add_field "Accept", "application/json, text/javascript, */*; q=0.01"
    req.add_field "X-Requested-With", "XMLHttpRequest"

    res = Net::HTTP.new(uri.host, uri.port).start do |http|
      debugger
      http.request(req)
    end
    puts "hello"
  end


end

bnb_crawler = AirbnbCrawler.new("Seattle")
bnb_crawler.crawl()
