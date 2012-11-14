def three_numbers_add_to_zero(all_numbers)
  res_sum = []
  level = 0
  used = [0]*all_numbers.size()
  puts do_three_numbers_add_to_zero(numbers, res_sum, level, used)
end

def do_three_numbers_add_to_zero(numbers, res_sum, level, used)
  if level == 3
    return true if res_sum.inject(:+) == 0
  end

  for i in (0...numbers.size())
    if used[i] == 0
      res += numbers[i]
      used[i] = true
      this_res = do_three_numbers_add_to_zero(numbers, res_sum, level+1, used)
      return true if this_res == true
    end
  end
  return false
end

nums = [0,2,1,2,2,3]
three_numbers_add_to_zero(nums)
