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

def arr_with_largest_block_second(sequence)
  max_sum = sequence[0]
  curr_max = sequence[0]
  curr_sum = 0
  for i in (1...sequence.size())
    curr_sum = sequence[i]+max_sum
    if curr_sum < 0
      curr_sum == 0
    else
       
    end
  end
  
end


def matrix_largest_block(mx)
  rows = mx.size
  cols = mx[0].size

  sum_mx = sum_rows_matrix(mx)
  largest = nil
  start_largest = [0, 0]
  end_largest = [0,0]

  for col1 in (0...cols)
    for col2 in (col1+1...cols)

      curr_sum = nil
      curr_best_sum = nil
      start_i = 0
      start_i2 = 0 # updates everytime curr_sum reses, but we don't want it to update if we reach the end 
      end_i = 0
      start_j = 0
      end_j = 0

      for i in (0...rows)
        start_i = start_i2
        row_sum = calc_row_sum(sum_mx, i, col1, col2) 
        curr_sum = row_sum + (curr_sum || 0)
        if curr_best_sum.nil? || curr_sum > curr_best_sum 
          curr_best_sum = curr_sum
          end_i = i
          start_j = col1
          end_j = col2
        end
        if curr_sum < 0
          curr_sum = 0
          start_i2 = i+1
        end
      end
      if largest < curr_best_sum 
        largest = curr_best_sum
        start_largest = [start_i, start_j] 
        end_largest = [start_j, end_j]
      end
    end
  end
  [largest, start_largest, end_largest]
end

def calc_row_sum(sum_mx, i,col1, col2)
  sum_mx[i][col2] - sum_mx[i][col1]
end

def sum_rows_matrix(mx)
  rows = mx.size 
  cols = mx[0].size + 1

  sum_mx = []*rows
  for i in (0...rows)
    sum_mx << Array.new(cols,nil)
  end

  for i in (0...rows)
    sum_mx[i][0] = 0
    sum_mx[i][1] = mx[i][1]
  end

  for i in (0...rows)
    for j in (2...cols)
      sum_mx[i][j] = sum[i][j-1] + sum[i][j]
    end
  end

  sum_mx
end

# similar to above but matrix with largest square that does not contain 0
# so given a matrix of 1's and 0's where (maybe there are mostly 1's) given a sub-matrix of the largest
# size where it has all 1s
#

def largest_submatrix_ones(mx)
  sum_mx = create_sum_submarix(mx)
  rows = mx.size
  cols = mx[0].size

  largest = nil
  start_lg = [0, 0]
  end_lg = [0, 0]
 
  for col1 in (0...cols)
    for col2 in (col1+1...cols)
      curr_largest = 0
      curr_sum = 0

      row = 0
      while row < rows
        if has_any_zeros?(sum_mx, row, col1, col2)
          row += 1
          curr_sum = 0
        else
          curr_sum += row_sum(sum_mx, row, col2) 
          if curr_largest < curr_sum
            curr_largest = curr_sum
          end
        end
      end

      if largest < curr_largest
        largest = curr_largest
      end
    end
  end
  
  largest

end

def has_any_zeroes?(mx_sum, row, col1, col2)
  sum = row_sum(mx_sum, row, col1, col2) 
  total_cols = col2 - col1 + 1
  return true if sum < total_cols
end 

def row_sum(sum_mx, row, col1, col2)
  sum_mx[row][col2] - sum_mx[row][col1]
end

def create_sum_submarix(mx)
  rows = mx.size
  cols = mx[0].size + 1
  sum_mx = [nil]*rows

  for i in (0..rows)
    sum_mx << Array.new(cols, nil)
  end

  for i in (0...rows)
    sum_mx[i][0] = 0
    sum_mx[i][1] = mx[i][0]
  end

  for i in (0...rows)
    for j in (2...cols)
      if mx[i][j] == 0
        sum_mx[i][j] = 0
      else
        sum[i][j] = sum[i][j-1] + sum[i][j]
      end
    end
  end
  sum_mx
end



############################################################
# only return the largest sum and not the matrix itself 
# easier to read
############################################################
#

# given an array of integers give the contigues block that has the largest sum. There can be negative numbers

def matrix_largest_block_simple(mx)
  rows = mx.size
  cols = mx[0].size+1
  sum_mx = sum_rows_matrix(mx)

  largest = nil

  for col1 in (0...cols)
    for col2 in (col1+1...cols)

      curr_sum = 0
      curr_best_sum = nil
      for i in (0...rows)
        row_sum = calc_row_sum(sum_mx, i, col1, col2) 
        curr_sum += row_sum 
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

def calc_row_sum(sum_mx, i,col1, col2)
  sum_mx[i][col2] - sum_mx[i][col1]
end

def sum_rows_matrix(mx)
  rows = mx.size
  cols = mx[0].size + 1

  sum_mx = []*rows
  for i in (0...rows)
    sum_mx << Array.new(cols,nil)
  end

  for i in (0...rows)
    sum_mx[i][0] = 0
    sum_mx[i][1] = mx[i][0]
  end

  for i in (0...rows)
    for j in (1...cols)
      sum_mx[i][j] = sum[i][j-1] + sum[i][j]
    end
  end

  sum_mx
end
