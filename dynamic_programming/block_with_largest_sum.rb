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


def matrix_largest_block(mx)
  rows = mx.size
  cols = mx[0].size

  largest = nil

  for col1 in (0...cols)
    for col2 in (col1...cols)

      curr_sum = nil
      curr_best_sum = nil
      for i in (0...rows)
        row_sum = row_sum(mx, i, col1, col2) 
        curr_sum = row_sum + (curr_sum || 0)
        if curr_best_sum.nil? || curr_sum > curr_best_sum 
          curr_best_sum = curr_sum
        end
        curr_sum = 0 if curr_sum < 0
      end
      largest = curr_best_sum if largest < curr_best_sum 
    end
  end
  largest
end

def row_sum(mx, i,col1, col2)
  mx[i][col2] - mx[i][col1]
end

def sum_rows_matrix(mx)
  rows = mx.size
  cols = mx[0].size

  sum_mx = []*rows
  for i in (0...rows)
    sum_mx << Array.new(cols,nil)
  end

  for i in (0...rows)
    sum_mx[i][0] = mx[i][0]
  end

  for i in (0...rows)
    for j in (1...cols)
      sum_mx[i][j] = sum[i][j-1] + sum[i][j]
    end
  end

  sum_mx
end

