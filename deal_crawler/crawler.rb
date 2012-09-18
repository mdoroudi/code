require 'nokogiri'
require 'open-uri'
require 'debugger'
require 'zlib'
require 'json'
require 'colorize'

#TODO 
# need to add login capabilities and deep crawl one level down
#http://bdbshop.com 
#http://www.enviius.com/
class DealCrawler
  DEAL_SITES = %w(http://gilt.com 
                  http://ruelala.com 
                  http://ideeli.com 
                  http://myhabit.com 
                  http://editorscloset.com 
                  http://www.biva.com/
                  http://www.modnique.com/)

  def initialize(brand_names)
    @header_hash = { "User-Agent" => 
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11"}
    @brands = brand_names
  end

  def crawl
    result = {}
    DEAL_SITES.each do |website|
      users_page = Nokogiri::HTML(open(website, @header_hash)).to_s 
      @brands.each do |brand_name|
        puts "crawling #{website} for #{brand_name}"
        if users_page.match(/#{brand_name}/)
          if result[website.to_sym]
            result[website.to_sym] << brand_name 
          else
            result[website.to_sym] = [brand_name]
          end
        end
      end
    end
    
    result 
  end

  def email_user
  end

end

dc = DealCrawler.new(["gucci", "Elie Tahari", "Kendra Scott"])
puts "The following sites have the indicated brands:".green
puts dc.crawl
