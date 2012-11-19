# random math functions, might seperate them later

# two positive numbers (including zero)
def gcd(num1, num2)
  smaller = num1 > num2 ? num2 : num1
  larger  = num1 > num2 ? num1 : num2
  return larger if smaller == 0

  while smaller != 0
    tmp = smaller
    smaller = larger % smaller
    larger = tmp
  end

  return larger
end

#puts gcd(1,2)
#puts gcd(2,0)
#puts gcd(42341234, 456)

# create an array of primes 0..number and assume all is prime, 
# mark 1 and 0 as false
# starting from teh next prime (2 starts) increment the index by squaring it
# for all i..n where its smaller than the max set the index to be false
# do this up to square root of number, and we set everything to the right true false
def all_primes_up_to(number)
  primes = [true]*(number+1)
  primes[0] = false
  primes[1] = false

  index = 2 
  while index < Math.sqrt(number)
    if primes[index]
      k = index*index
      while k <= number
        primes[k] = false
        k += index
      end
    end
    index += 1
  end
  
  primes.each_index {|i| primes[i] = primes[i] ? i : nil }.compact
end

#puts all_primes_up_to(100)

# check from i from 2 to square root of number
# skip by 2 since even numbers are not prime
def is_prime?(number)
  return true if number == 2
  return false if number < 2
  return false if number & 1 == 0

  i = 3
  while i < Math.sqrt(number)
    return false if number % i == 0
    i += 1
  end
  return true
end

#puts is_prime?(10001)

