require 'debugger'
def print_subsets(set) 
  puts "subsets of "+set.to_s
  subsets = [""]

  set.each do |char|
    curr_subsets = []
    subsets.each do |subset|
      curr_subsets << subset+char
    end
    subsets = subsets + curr_subsets
  end
  
  puts subsets
  
end


print_subsets(%w(1 2 3))
print_subsets(%w(1 2 3 5 6 7))
