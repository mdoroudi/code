require 'debugger'

def string_exist(matrix, word)
  rows = matrix.size
  cols = matrix[0].size
  visited = [Array.new(cols, 0)]*rows
  rval = false

  for i in (0...rows)
    for j in (0...cols)
      if matrix[i][j] == word[0]
        visited [i][j] = 1
        rval = do_string_exist(matrix, visited, word[1..word.size], [i,j])
        unless rval
          visited =  [Array.new(cols, 0)]*rows
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
  i_range = ([0, ij[0]-2].max .. [matrix.size-1, ij[0]+1].min)
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
#puts matrix.to_s

#matrix = [%w(a b c), %w(d e f), %w(m i n)]
matrix = [%w(a b c)]
puts string_exist(matrix, "bc")
