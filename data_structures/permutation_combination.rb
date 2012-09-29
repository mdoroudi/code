require 'debugger'
require 'colorize'

def permutation(str)
  str_length = str.size
  result = " "*str_length
  used_chars = Array.new(str_length, 0)
  recursiveLev = 0
  do_permutation(str, result, used_chars, str_length, recursiveLev)
end

def do_permutation(str, str_res, used, length, recursLev)
  if recursLev == length
    puts str_res
    puts "--------------------- next stack --------------".blue
    return
  end

  for i in (0...length)
    if used[i] == 1
      next
    else
      used[i] = 1
      str_res[recursLev] = str[i]
      puts "before  i: #{i}  -  level: #{recursLev}  -  used: #{used.to_s}".green
      do_permutation(str, str_res, used, length, recursLev+1)
      puts "after   i: #{i}  -  level: #{recursLev}  -  used: #{used.to_s}".green
      used[i] = 0
    end
  end

end

def combination(str)
  result = [""]
  do_combination(str, result)
end

def do_combination(str, prev_combinations)
  for i in (0...str.size)
    i_combination = []
    for j in (0...prev_combinations.size)
      item = prev_combinations[j]+str[i]
      i_combination << item
    end
    prev_combinations.concat(i_combination)
  end
  puts "total combinations = #{prev_combinations.size}"
  prev_combinations[1..-1]
end

puts combination("1234")

#permutation("mina")
