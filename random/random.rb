require 'debugger'

def is_integer?(value)
  return false if value.nil? || value.size == 0
  start_index = (value[0] =~ /[-+]/).nil? ? 0 : 1

  if (start_index == 1 && value.size > 1) || start_index == 0
    for i in (start_index...value.size)
      return false if (value[i] =~ /[0-9]/).nil?
    end
  else
    return false
  end
  return true
end

#puts is_integer? '-12'
puts is_integer? '122'
puts is_integer? '22-'
puts is_integer? '-'

