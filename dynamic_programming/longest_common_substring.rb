# retusn the longest length, along with all the longest common substrings 
def longest_common_sub_string(str1, str2)
  count_table = [0]*str1.size
  for i in (0...str1.size)
    count_table[i] = [0]*str2.size
  end
  max_len = 0
  all_res = []

  for i in (0...str1.size)
    for j in (0...str2.size)
      if str1[i] == str2[j]
        if i == 0 || j == 0
          count_table[i][j] = 1
        else
          count_table[i][j] = count_table[i-1][j-1]+1
          curr_str = str1[i-max_len..i]
          if max_len < count_table[i][j]
            max_len = count_table[i][j]
            all_res = [curr_str]
          elsif max_len == count_table[i][j]
            all_res << curr_str
          end
        end
      end
    end
  end

  return {longest_len: max_len, sub_strs: all_res}
end

puts longest_common_sub_string("minadoroudi", "doroudi")
