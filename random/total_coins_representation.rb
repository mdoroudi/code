
def total_coins_representation(n)
  total_representation(n, 0, [])
end
def total_representation(n, total_coins, representations)
  if n == 0 
    puts total_coins
    representations << total_coins
    return representations
  end
  return -1 if n < 0

  total_representation(n - 25, total_coins+1, representations) if n >= 25
  total_representation(n - 5, total_coins+1, representations ) if n >= 5
  total_representation(n - 10, total_coins+1, representations) if n >= 10
  total_representation(n - 1, total_coins+1, representations) if n >= 1
end

#total_coins_representation(1)
#total_coins_representation(2)
#total_coins_representation(3)
#total_coins_representation(4)
total_coins_representation(5)
#total_coins_representation(13)
