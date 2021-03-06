#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'csv'
require 'date'
require 'debugger'
#$LOAD_PATH << '.'

# INPUTS & OUTPUT:
#
# properties: p_id, lat, lng, price
# calendar: p_id, date, available, price
# search: s_id, lat, lng, check_in, check_out 
# output: s_id, rank, p_id, total_price 

class BnbPropertySearch
  def initialize
    @all_properties = CSV.read("properties.csv")
    @calendar = CSV.read("calendar.csv")
    @searches = CSV.read("searches.csv")
    @cal_hash = {}
    @calendar.each do |item|
      if @cal_hash[item[0]].nil?
        @cal_hash[item[0]] = [item]
      else
        @cal_hash[item[0]] << item
      end
    end
  end

  # O(n)
  def get_closeby_properties(lat, lng, properties)
    lat_range = ( lat - 1 .. lat + 1 )
    lng_range = ( lng - 1 .. lng + 1 )
    result_properties = []
    properties.each do |property|
      if lat_range.include?(property[1].to_f) && lng_range.include?(property[2].to_f)
        result_properties << property
      end
    end
    puts "found #{result_properties.size} properties close to #{lat} #{lng}"
    result_properties
  end

  # for the given check_in and check_out search date, for all the properties in a location get the available ones
  # O(n^2) since the properties are filtered from get_closeby_properties this is almost constant time in our case
  # but in general if there are a lot of properties and a lot of exceptional dates for each then it can be n^2
  def get_available_properties(check_in, check_out, properties)
    result_properties = []
    property_available = false
    properties.each do |property|
      if !@cal_hash[property[0]].nil?
        property_cals = @cal_hash[property[0]]
        property_cals.each do |cal|
          date = Date.parse(cal[1])
          property_available = !(( date >= check_in && date < check_out ) && cal[2].to_i == 0) 
          break unless property_available  
        end
      else
        property_available = true
      end

    result_properties << property if property_available
    end
    puts "found #{result_properties.size} properties available for the dates"
    result_properties
  end

  # the properties passed into here are available and closeby properties to the search
  # O(n) + O(n Log(n)) = O(n Log(n))
  def get_properties_total_price(check_in, check_out, search_id, available_properties)
    properties_total_price = []
    total_days = (check_out - check_in).to_i        

    available_properties.each do |property|
      property_cals = @cal_hash[property[0]]
      exceptional_days = 0

      if property_cals.nil?
         total_price = total_days * property[3].to_f
      else
        property_cals.each do |cal|
          cal_date = Date.parse(cal[1])
          exceptional_days = 0
          total_price = 0
          if cal_date >= check_in && cal_date < check_out 
            exceptional_days =+ 1
            total_price =+ cal[3].to_f
          end
        end
        total_price =+ (total_days - exceptional_days)*property[3].to_f
      end
      properties_total_price << [search_id, -1, property[0], total_price]
    end
    properties_total_price.sort_by! {|item| item[3]}
    properties_total_price.each_with_index do |item, index|
      item[1] = index
    end
    properties_total_price
  end

  # O(n) + O(n) + O(n Log(n)) + O(n^2) = O(n^2) 
  def search_tenth_cheapest_properties(search)
    lat = search[1].to_f
    lng = search[2].to_f
    check_in = Date.parse(search[3])
    check_out = Date.parse(search[4])

    closeby_properties = get_closeby_properties(lat, lng, @all_properties)
    available_properties = get_available_properties(check_in, check_out, closeby_properties)  
    properties_total_price = get_properties_total_price(check_in, check_out, search[0], available_properties)

    properties_total_price[0...10]
  end

  # O(10) = O(1)
  def write_results_to_file(result_array)
    CSV.open("search_results.csv", "ab") do |csv|
      result_array.each do |result|
        csv << result
      end
    end
  end

  # the end runtime is O(n*nLog(n)) + O(n*n) + O(n^3)
  # O(n*nLog(n)) is pretty faster becuase  n(long(n)) is at most 10*long(10)) then it becomes n^2
  # n^2 * O(1) + O(n^3) so the result is O(n^3)
  # first n = all the search terms, we have to go through all of them so can't be any faster
  # second n = all the properties, we can't make this faster since for each search it has to go throuh all the properties to see if they are in the area
  # third n = all calendar rows for a given property - in our case this is small and constant time
  def search_all
    @searches.each do |search|
      tenth_cheapest = search_tenth_cheapest_properties(search)
      write_results_to_file(tenth_cheapest)
    end
  end


end

searchBnb = BnbPropertySearch.new()
searchBnb.search_all
