b0VIM 7.3      Q�JPTM��  minadoroudi                             mina-doroudis-MacBook-Pro.local         ~minadoroudi/work/airbnb_coding_challenge/minas_new_airbnb_search.rb                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         utf-8 3210    #"! U                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 tp           @                            :       ?                            l                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ad  �  �     @       �  �  �  �  �  �  �  }  {  W  .  �  �  �  �  �  x  O  &    �  �  �  �  �  y  q  k  j  a  .    �  �  �  M  '      �  �  �  �  9  �
  X
  
  �	  �	  �	  �	  g	  C	  	  �  �  �  |  Z  P  O      �  l    �  �  �  �  p  U  T  8    �  �  �  �  s  8    �  �  �  �  �  9  1  �  �  �  �  �  �  �  Q  8    �  �  �  �  )  �  �  �  �  �  f  4    �  �  �  9      end       end         csv << result       result_array.each do |result|     CSV.open("search_results.csv", "ab") do |csv|   def write_results_to_file(result_array)    end     properties_total_price[0...10]      properties_total_price = get_properties_total_price(check_in, check_out, search[0], available_properties)     available_properties = get_available_properties(check_in, check_out, closeby_properties)       closeby_properties = get_closeby_properties(lat, lng, @all_properties)      check_out = Date.parse(search[4])     check_in = Date.parse(search[3])     lng = search[2].to_f     lat = search[1].to_f   def search_tenth_cheapest_properties(search)    end     properties_total_price     end       item[1] = index     properties_total_price.each_with_index do |item, index|     properties_total_price.sort_by! {|item| item[3]}     end       properties_total_price << [search_id, -1, property[0], total_price]       end         total_price =+ (total_days - exceptional_days)*property[3].to_f         end           end             total_price =+ cal[3].to_f             exceptional_days =+ 1           if cal_date >= check_in && cal_date < check_out            total_price = 0           exceptional_days = 0           cal_date = Date.parse(cal[1])         property_cals.each do |cal|       else          total_price = total_days * property[3].to_f       if property_cals.nil?        exceptional_days     puts "found #{result_properties.size} properties available for the dates"     end    puts "found #{result_properties.size} properties available for the dates"     end     result_properties << property if property_available        end         property_available = true       else         end           break unless property_available             property_available = !(( date >= check_in && date < check_out ) && cal[2].to_i == 0)            date = Date.parse(cal[1])         property_cals.each do |cal|         property_cals = @cal_hash[property[0]]       if !@cal_hash[property[0]].nil?     properties.each do |property|     property_available = false     result_properties = []   def get_available_properties(check_in, check_out, properties)   # but in general if there are a lot of properties and a lot of exceptional dates for each then it can be n^2   # O(n^2) since the properties are filtered from get_closeby_properties this is almost constant time in our case   # for the given check_in and check_out search date, for all the properties in a location get the available ones    end     result_properties     puts "found #{result_properties.size} properties close to #{lat} #{lng}"     end       end         result_properties << property       if lat_range.include?(property[1].to_f) && lng_range.include?(property[2].to_f)     properties.each do |property|     result_properties = []     lng_range = ( lng - 1 .. lng + 1 )     lat_range = ( lat - 1 .. lat + 1 )   def get_closeby_properties(lat, lng, properties)   # O(n)    end     end       end         @cal_hash[item[0]] << item       else         @cal_hash[item[0]] = [item]       if @cal_hash[item[0]].nil?     @calendar.each do |item|     @cal_hash = {}     @searches = CSV.read("searches.csv")     @calendar = CSV.read("calendar.csv")     @all_properties = CSV.read("properties.csv")   def initialize class AirbnbPropertySearch  # output: s_id, rank, p_id, total_price  # search: s_id, lat, lng, check_in, check_out  # calendar: p_id, date, available, price # properties: p_id, lat, lng, price # # INPUTS & OUTPUT:  #$LOAD_PATH << '.' require 'debugger' require 'date' require 'csv' # -*- coding: utf-8 -*- #!/usr/bin/env ruby ad  y  �            �  �  �  a  1  �  ;  �  �  �  h  <  4  .  -  ,  (  '  �  �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               searchAirbnb.search_all searchAirbnb = AirbnbPropertySearch.new()  end     end     end       write_results_to_file(tenth_cheapest)       tenth_cheapest = search_tenth_cheapest_properties(search)     @searches.each do |search|   def search_all   # third n = all calendar rows for a given property - in our case this is small and constant time   # second n = all the properties, we can't make this faster since for each search it has to go throuh all the properties to see if they are in the area   # first n = all the search terms, we have to go through all of them so can't be any faster   # n^2 * O(1) + O(n^3) so the result is O(n^3)   # O(n*nLog(n)) is pretty faster becuase  n(long(n)) is at most 10*long(10)) then it becomes n^2   # the end runtime is O(n*nLog(n)) + O(n*n) + O(n^3)    end ad  f  j     :       �  �  �  �  g    �  �  �  �  a  F  E  )  �  �  �  �  ~  d  )    �  �  �  �  Q  G  �  �  �  �  n  f  K  E  D    �
  �
  �
  �
  g
  f
  
  �	  N	  M	  *	  $	  #	  	  �  �  �  |  r  j                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                end       end         csv << result       result_array.each do |result|     CSV.open("search_results.csv", "ab") do |csv|   def write_results_to_file(result_array)   # O(10) = O(1)    end     properties_total_price[0...10]      properties_total_price = get_properties_total_price(check_in, check_out, search[0], available_properties)     available_properties = get_available_properties(check_in, check_out, closeby_properties)       closeby_properties = get_closeby_properties(lat, lng, @all_properties)      check_out = Date.parse(search[4])     check_in = Date.parse(search[3])     lng = search[2].to_f     lat = search[1].to_f   def search_tenth_cheapest_properties(search)   # O(n) + O(n) + O(n Log(n)) + O(n^2) = O(n^2)     end     properties_total_price     end       item[1] = index     properties_total_price.each_with_index do |item, index|     properties_total_price.sort_by! {|item| item[3]}     end       properties_total_price << [search_id, -1, property[0], total_price]       end         total_price =+ (total_days - exceptional_days)*property[3].to_f         debugger if property[0].to_i == 8764         end           end             total_price =+ cal[3].to_f             exceptional_days =+ 1           if cal_date >= check_in && cal_date < check_out            total_price = 0           exceptional_days = 0           cal_date = Date.parse(cal[1])         property_cals.each do |cal|       else          total_price = total_days * property[3].to_f       if property_cals.nil?        exceptional_days = 0       property_cals = @cal_hash[property[0]]     available_properties.each do |property|      total_days = (check_out - check_in).to_i             properties_total_price = []   def get_properties_total_price(check_in, check_out, search_id, available_properties)   # O(n) + O(n Log(n)) = O(n Log(n))   # the properties passed into here are available and closeby properties to the search    end     result_properties 