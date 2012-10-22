require 'debugger'

# This is the slow but easier O(exponential) solution
# O 2^(n/2)*2 + extra 
def fibonacci_recursive(number)
  return 0 if number == 0
  return 1 if number == 1
  return 1 if number == 2
  fibonacci_recursive(number-1) + fibonacci_recursive(number-2)
end

# this is the DB O(n) solution
def fibonacci_dp(number)
 n1 = 1
 n2 = 1
 return 0 if number == 0
 return n1 if number == 1
 return n2 if number == 2

 count = 2
 while count < number do
  tmp = n2
  n2 = n2 + n1
  n1 = tmp
  count += 1
 end

 n2
end
