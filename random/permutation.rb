require 'debugger'
require 'colorize'


# all permutation of str, there are n! where n is size of the string
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

# set of all combination of str, so combination of size 0 to size str.size()
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

def selection(lists)
  do_selection(lists, "", lists.size, 0)
end

def do_selection(lists, str_res, length, level)
  if level == length 
    puts str_res
    return ""
  end

  for i in (0...lists.size)
    for j in (0...lists[i].size)
      str_res[level] = lists[i][j]
      do_selection(lists[i+1...lists.size], str_res, length, level+1)
    end
  end
end

def telephone_words(number)
  number = number.split('-').join('')
  len = number.size
  res = ' '*len
  level = 0
  words_i = 0
  print_telephone_words(number, res, level, len)
end

def print_telephone_words(number, res, level, len)
  if level == len
    puts res
    return
  end

  if number[level] == '1' || number[level] == '0'
    res[level] = number[level]
    print_telephone_words(number, res, level+1, len)
  end
  for index in (0...3) do 
    next if  number[level] == '1' || number[level] == '0'
    res[level] = get_char_key(number[level], index)
    print_telephone_words(number, res, level+1, len)
  end

  return
end

def get_char_key(key, index)
  get_char_keys(key.to_i)[index]
end

def get_char_keys(key)
  case key
  when 2 
    %w(A B C)
  when 3
    %w(D E F)
  when 4
    %w(G H I)
  when 5
    %w(J K L)
  when 6
    %w(M N O)
  when 7
    %w(P R S)
  when 8
    %w(T U V)
  when 9
    %w(W X Y)
  end
end

#telephone_words("402")

#permutation("mina")
#puts combination("mina")
#list = [%w(1 2 3), %w(5 6 7), %w(0 9 8)]
list = [%w(1 2), %w(5 6)]
selection(list)
