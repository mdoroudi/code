require 'debugger'
require 'colorize'

def string_exist(matrix, word)
  puts "matching for #{word}".green
  rows = matrix.size
  cols = matrix[0].size
  rval = false
  visited = empty_visited(rows, cols)

  for i in (0...rows)
    for j in (0...cols)
      if matrix[i][j] == word[0]
        visited [i][j] = 1
        rval = do_string_exist(matrix, visited, word[1..word.size], [i,j])
        if rval 
          return rval
        else
          visited = empty_visited(rows, cols)
        end
      end
    end
  end
  rval
end

def do_string_exist(matrix, visited, word, curr_ij)
  return true if word.size == 0 

  rows = matrix.size
  cols = matrix[0].size
  neighs = char_neighbors(matrix, visited, curr_ij, word[0]) 
  return false if neighs.size == 0

  neighs.each do |nei|
    visited[nei[0]][nei[1]] = 1
    return do_string_exist(matrix, visited, word[1..word.size], nei) 
  end
end


def char_neighbors(matrix, visited, ij, char)
  res = []
  i_range = ([0, ij[0]-1].max .. [matrix.size-1, ij[0]+1].min)
  j_range = ([0, ij[1]-1].max .. [matrix[0].size-1, ij[1]+1].min)
  for i in i_range
    return [] if i >= matrix.size
    for j in j_range
      return [] if j >= matrix[0].size
      if matrix[i][j] == char && visited[i][j] != 1
        res << [i,j]
      end
    end
  end
  res
end

def empty_visited(rows, cols)
  visited = []
  for i in (0...rows)
    visited << Array.new(cols, 0)
  end
  visited
end

#alphabet = ("a".."z").to_a
#matrix = [] 
#for i in (0...10)
  #matrix << Array.new(10, "")
#end

#for i in (0...10)
  #for j in (0...10)
    #matrix[i][j] = alphabet[rand(0..25)]
  #end
#end
#matrix.each do |row|
  #puts row.to_s 
#end

#matrix = [%w(a b c), %w(d e f), %w(m i n)]
matrix = 
  [["m", "w", "k", "x", "g", "b", "g", "m", "z", "w"],
   ["p", "o", "o", "a", "b", "d", "h", "w", "b", "y"],
   ["n", "i", "d", "o", "t", "d", "h", "g", "v", "b"],
   ["q", "d", "q", "r", "i", "f", "b", "m", "a", "h"],
   ["b", "v", "v", "u", "c", "n", "o", "r", "w", "y"],
   ["y", "j", "o", "s", "f", "l", "l", "k", "l", "d"],
   ["h", "b", "l", "m", "a", "t", "v", "r", "g", "a"],
   ["r", "q", "h", "o", "w", "x", "c", "c", "b", "p"],
   ["x", "f", "t", "n", "s", "f", "p", "q", "c", "c"],
   ["o", "a", "o", "z", "s", "p", "k", "n", "l", "k"]]

#puts string_exist(matrix, "abc")
#puts string_exist(matrix, "mwkx")
#puts string_exist(matrix, "ndqv")
#puts string_exist(matrix, "vcck")
#puts string_exist(matrix, "wm")
#puts string_exist(matrix, "gxkwm")
#puts string_exist(matrix, "poo")
#puts string_exist(matrix, "kodax")
#puts string_exist(matrix, "vcqp")

puts string_exist(matrix, "kodor")

