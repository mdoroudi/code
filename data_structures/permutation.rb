require 'debugger'

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
    return
  end

  for i in (0...length)
    if used[i] == 1
      next
    else
      used[i] = 1
      str_res[recursLev] = str[i]
      do_permutation(str, str_res, used, length, recursLev+1)
      used[i] = 0
    end
  end

end

permutation("mina")
