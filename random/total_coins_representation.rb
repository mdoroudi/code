require 'debugger'
def total_coins_representation(n)
  puts "total ways to represent #{n}:"
  puts total_representation(n, 0, [])
end
def total_representation(n, total_coins, representations)
  return 1 if n == 0 
  return 1 if n == 1
  return 0 if n < 0

  ways = 
    total_representation(n - 25, total_coins+1, representations) + 
    total_representation(n - 5, total_coins+1, representations ) +
    total_representation(n - 10, total_coins+1, representations) + 
    total_representation(n - 1, total_coins+1, representations) 
  return ways
end

total_coins_representation(1)
total_coins_representation(2)
total_coins_representation(3)
total_coins_representation(4)
total_coins_representation(5)
total_coins_representation(13)
total_coins_representation(10)
total_coins_representation(9)
