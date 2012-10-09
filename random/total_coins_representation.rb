require 'debugger'
def total_coins_representation(n)
  puts "total ways to represent #{n}:"
  puts total_calc(n)
end


def total_calc(n)
  max_q = n/25
  max_d = n/10
  max_n = n/5
  max_p = n
  
  # n = x*1 + y*5 + j*10 + w*25
  total = 0

  for w in (0..max_q)
    for j in (0..max_d)
      for y in (0..max_n)
        for x in (0..max_p)
          if n ==  x*1 + y*5 + j*10 + w*25 
            total += 1
          end
        end
      end
    end
  end
 return total 
end
puts total_coins_representation(1)
puts total_coins_representation(2)
puts total_coins_representation(3)
puts total_coins_representation(4)
puts total_coins_representation(5)
puts total_coins_representation(13)
puts total_coins_representation(10)
puts total_coins_representation(9)
