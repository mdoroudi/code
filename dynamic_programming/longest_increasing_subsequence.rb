require 'debugger'
# Given a sequence of numbers, find the 'longest subsequence' of numbers
# which is non-decreasing. The subsequence does not have to be contiguous or uniqe
# 
# ex
# 0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15, …
# the Longest increasing sub sequence is 
# 0, 2, 6, 9, 13, 15
# or
# 0, 4, 6, 9, 11, 15
# so it does not have to be unique or continguous
#
class DynamicProgramming
  def self.longest_increasing_subsequence(sqnc)
    length = sqnc.size
    len = [1]*length            # length of longest ISS for upto character i, at the begginign every element is its own LISS
    parents_arr = [nil]*length  # predecesor of longest ISS of the sqnc[i]
    largest = 0                 # the length of the longest ISS found so far

    for index in (1...length)
      j = index - 1
      while j >= 0 do
        if sqnc[j] <= sqnc[index] && len[j] >= len[index]
          len[index] = len[j]+1
          parents_arr[index] = j
          largest = [largest, len[index]].max
        end
        j -= 1
      end
    end

    max_indices = []
    len.each_with_index {|item,index| max_indices << index if item == largest}

    max_indices.each do |index|
      res = []
      res << sqnc[index]
      while !parents_arr[index].nil? do 
        index = parents_arr[index]
        res << sqnc[index]
      end
      return res.reverse 
    end
  end

end

# Find the largest possible difference in an array of integers, such that the smaller integer occurs earlier in the array. 
def largest_difference(arr)
  max = -1
  i1 = -1
  i2 = -1

  for i in (1...arr.size)
    j = i - 1
    while j >= 0
      diff = arr[i] - arr[j]
      if diff > max
        max = diff
        i1 = j
        i2 = i
      end
      j -= 1
    end
  end
  return [max, i1, i2]
end

def largest_difference_speedy(arr)
  max = -(1.0/0) 
  curr_min = 1.0/0
  i1 = -1
  i2 = -1
  for i in (1...arr.size)
    j = i-1
    curr_min = [curr_min, arr[j]].min
    diff = arr[i] - curr_min
    if diff >= 0 && max <= diff 
      max = diff
      i2 = i
      i1 = (curr_min == arr[j]) ? j : i1
    end
  end
  return [max, i1, i2]
end

puts largest_difference([10,9,8]).to_s
puts largest_difference_speedy([10,9, 8]).to_s
