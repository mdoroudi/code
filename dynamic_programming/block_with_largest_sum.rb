require 'debugger'

# given an array of integers give the contigues block that has the largest sum. There can be negative numbers

def array_largest_block(sequence)
  len = sequence.size
  parents = [nil]*len
  my_largest = sequence
  largest = sequence.max

  for index in (1...len)
    if my_largest[index] < my_largest[index] + my_largest[index - 1]
      my_largest[index] = my_largest[index] + my_largest[index - 1]
      parents[index] = index - 1
      largest = [largest, my_largest[index]].max
    end
  end

  end_index_of_largest_block = my_largest.find_index(largest)
  i = end_index_of_largest_block
  res = []
  res << sequence[i]
  while !parents[i].nil?
    i = parents[i]
    res << sequence[i]
  end
  return {l_sum: largest, start: i, end: end_index_of_largest_block}
end
