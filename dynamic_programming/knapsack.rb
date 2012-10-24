require 'debugger' 
# given a set of items, each with a weight and a value, find the number of each item
# to be included in a set where the weight is minimized and price is maximized

# for now we just return the best weight and max price
def knap_sack(items, max_weight)
  total_items = items.size
  # sort the items based on weight
  items = sort_items(items) 
  best_weight = Float::INFINITY
  best_price = 0
  
  # calculate the best price for weight starting from 0 to max_weight
  # each index the max price on it and the index itself is the weight
  best_res = [nil]*(max_weight+1)
  best_res[0] = 0

  for curr_w in (1..max_weight)
    j = 0
    while (j < total_items) do
      if items[j][:w] <= curr_w
        curr_possible_price = best_res[curr_w - items[j][:w]] + items[j][:p] 
        if best_res[curr_w - 1 ] < curr_possible_price
          best_res[curr_w] = curr_possible_price 
        else
          best_res[curr_w] = best_res[curr_w - 1]
        end
        if best_price < best_res[curr_w]
          best_price = best_res[curr_w]
          best_weight = curr_w
        end
      else
        best_res[curr_w] = best_res[curr_w-1] if best_res[curr_w].nil?
      end
      j += 1
    end
  end
  
  {weight: best_weight, price: best_price}
end

def sort_items(items)
  items.sort {|pair1, pair2| pair1[:w] <=> pair2[:w]}
end
