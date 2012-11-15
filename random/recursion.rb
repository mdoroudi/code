require 'debugger'

# getting combination of n choose x
def n_comb_rec(nums, combination_size)
  puts "#{combination_size} choose #{nums.size()}"
  return [] if combination_size > nums.size()

  all_res = []
  used = [false]*nums.size()
  do_n_comb_rec(combination_size, nums, [], 0, used, all_res, 0)

  puts all_res.size()
  return all_res.size()
end

def do_n_comb_rec(combination_size, nums, curr_res, level, used, all_res, i_start)
  if level == combination_size
    all_res << curr_res
    puts curr_res.to_s
    return 
  end

  for i in (i_start...nums.size())
    curr_res[level] = nums[i]
    used[i] = true
    do_n_comb_rec(combination_size, nums, curr_res, level+1, used, all_res, i+1)
  end

end

# pick 3 out of n numbers
def three_combinations(nums)
  res = []
  for i in (0...nums.size())
    for j in (i+1...nums.size())
      for k in (j+1...nums.size())
        res << [nums[i], nums[j], nums[k]]
      end
    end
  end
  puts res.size()
  res
end

# if sum of any 3 out of n numbes add to zero, takes O(n^3)
def three_add_to_zero?(nums)
  for i in (0...nums.size())
    for j in (i+1...nums.size())
      for k in (j+1...nums.size())
        if nums[i]+nums[j]+nums[k] == 0
          return true;
        end
      end
    end
  end
  return false
end

def three_add_to_zero_faster?(nums)
  my_hash = {}
  for i in (0...nums.size())
    for j in (i+1...nums.size())
      sum = nums[i]+nums[j]
      curr_pair = [nums[i], nums[j]]
      if my_hash[sum].nil?
        my_hash[sum] = [curr_pair]
      else
        my_hash[sum] << curr_pair
      end
    end
  end
  nums.each do |number|
    return [number]+my_hash[-number][0] if !my_hash[-number].nil?
  end
  return false
end

nums = [0,1,2,-3,4,5]
#puts "supposed to have total: #{nums.size()*(nums.size()-1)*(nums.size()-2)/6} for "+nums.to_s
#three_numbers_add_to_zero(nums)
#three_combinations(nums)
#n_comb_rec(nums, 3)
#n_comb_rec(nums,1)
puts three_add_to_zero_faster?(nums).to_s
