require 'debugger'

# given a list of N coin types (where we have infinity many of each type) and a 
# total sum of money, find the minimum number of coins where sum of which is the
# total sum
# so for example sum can be $11.50 and hour coins [1, 10, 25, 50, 100]
#
# we create a min_costs array (min) where at each point it figures out how many 
# coins it need to reach that index, initialy everything is infinity, besides the 0. 
# for example min[0] is how many coins we need to add up to 0 cents, and min_cost[1] 
# is how many coins we need to add up to 1 cent

def min_coins_sum(sum, coin_types)
  min = [Float::INFINITY]*(sum+1) 
  min[0] = 0
  n = coin_types.size

  # go through array of min_costs and calculate each min_cost untill we actually get to calcuate min_cost of sum 
  for index in (1..sum)
    # go through array of coin types and for each use it for the current cost untill you find the optimum
    for j in (0...n)
      # if current_coin is less than the current sum (index) && 
      # for the current price + a-type-of-coin min_cost + 1 for that type of coin, if it's less than whats
      # already in min costs array then replace the min costs array.
      # The very first time for each cost (index) since the 
      if ( coin_types[j] <= index ) && ( min[index - coin_types[j]] + 1 < min[index] )
        min[index] = min[ index - coin_types[j] ] + 1
      end
    end
  end
  min[sum]
end

