require 'debugger'

# Given an arrangement of S = {s1, s2, s3 ... sn} of non negative numbers and an integer k
# partition s into k ranges, so it minimize the maximum sum over all ranges
# 
# This problem often rises in parallel processing, since we seek to balance the work across
# processors so as to minimize the totla elapase time
# we define a Matrix of Min Max  partitions M[n,k] where n is total of non negative numbers in a partition
# starting from 1 (1 partition to n partition) and k is total partitions starting 
# from 1 to k partitions. 
# for clarity we call M = cost_matrix, since it calculates the cost at each (i,j)

def balance_partition(numbers, total_partitions)
  # we like to start from index 1 so it's easier for example to say 1 book...
  tmp = [nil] + numbers
  numbers = tmp
  total_n = numbers.size
  
  # we also do total_partitions+1 so we start from index 1 instead of 0
  cost_matrix = [[]*(total_partitions+1)]*(total_n)

  # prefix sum
  p = []*(total_n)
  p[0] = 0
  for i in (1..total_n)
    p[i] = p[i-1] + number[i]
  end

  # initialize for the base cases: edges
  for i in (1..n)
    cost_matrix[i][1] = p[i] 
  end
  for k in (1..total_partitions)
    cost_matrix[1][k] = numbers[1]
  end

  for i in (2..total_n)
    for j in (2..total_partitions)
      cost_matrix[i][j] = Float::INFINITY
      for x in (1..i-1)
        s = [ cost_matrix[x, j-1] , p[i] - p[x] ].max
        if cost_matrifx[i,j] > s
          cost_matrix[i,j] = s
          d[i,j] = x
        end
      end
    end
  end
end

# my own version

# we increase the size of numbers and totla partition by 1, so we can start from
# index 1. that way the base case of 1 partition and 1 number makes sense, otherwise
# we have to do 0 partition and 0 number adn dividing a number to 0 partition is infinity
# so it won't make sense

def linear_partition(seq, total_partitions)
  return [] if total_partitions <= 0

  seq = [nil]+seq 
  total_n = seq.size
   

  # creating a prefix so we know for each index if all the seq from 0..index 
  # where in a partition what would be the cost
  p = []*total_n
  p[0] = 0
  for i in (1..total_n)
    p[i] = p[i-1] + number[i]
  end

  cost_matrix = create_linear_partition_table(seq, total_partitions)

  # dividers table
  dividers =  [[]*(total_partitions+1)]*(total_n)

end

def create_linear_partition_table(seq, k)
  n = seq.size + 1
  
  # we also do total_partitions+1 so we start from index 1 instead of 0
  cost_table = [[]*(total_partitions+1)]*(n)

  ### set the base cases, which are left and bottom edges of the matrix ###

  # j = 1: cost for partitioning seq to partition of size 1 which is the sum of the current seq
  for i in (1..n)
    cost_table[i][1] = p[i]
  end

  # partitioning first number to 1..j partitions 
  for j in (1..k)
    cost_table[1][j] = seq[1]
  end

  for i in (2..n)
    for j in (2..k)
      cost_table[i][j] = [[].max].min 
    end
  end

  cost_table
end
#example

seq = [1, 8, 2, 3, 5]
k = 3 
