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


# fib of three numbers
def fib_rec_3(number)
  return 0 if number == 0
  return 1 if number == 1
  return 2 if number == 2


  res = fib_rec_3(number - 1) + fib_rec_3(number - 2) + fib_rec_3( number - 3)
  return res
end


def fib_it_3(number)
  n0 = 0
  n1 = 1
  n2 = 2
  
  return n0 if number == 0
  return n1 if number == 1
  return n2 if number == 2

  count = 2
  while count < number
    tmp2 = n2
    n2 = n0 + n1 + n2
    n0 = n1
    n1 = tmp2
    count += 1
  end
  return n2 
end

puts "fib 3"
puts fib_rec_3(3)
puts fib_it_3(3)

puts "fib 2"
puts fib_rec_3(2)
puts fib_it_3(2)

puts "fib 1"
puts fib_rec_3(1)
puts fib_it_3(1)

puts "fib 4"
puts fib_rec_3(4)
puts fib_it_3(4)

puts "fib 5"
puts fib_rec_3(5)
puts fib_it_3(5)

puts "fib 10"
puts fib_rec_3(10)
puts fib_it_3(10)
