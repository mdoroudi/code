require 'debugger'

def string_exist(matrix, word)
  rows = matrix.size
  cols = matrix[0].size
  visited = [Array.new(cols, 0)]*rows

  for i in (0..rows)
    for j in (0..cols)
      if matrix[i][j] = word[0]
        visited [i][j] = 1
        do_string_exist(matrix, visited, word[1..word.size], [i,j])
      end
    end
  end
end

def do_string_exist(matrix, visited, word_rest, curr_ij)
  rows = matrix.size
  cols = matrix[0].size

  for for i in (0...rows)
    for j in (0...cols)

      wi = 0
      while wi < word.size
        if matrix[i][j] == word[wi]
          visited[i][j] = 1
          wi += 1
          neighs = char_neighbors(matrix, visited, [i,j], word[wi]) 
          neighs.each do |ng|
            string_exist(matrix, word)         
          end
        end
      end

    end
  end
  
  return false
end


def char_neighbors(matrix, visited, ij, char)
  res = []
  for i in (ij[0]-1..ij[0]+1)
    for j in (ij[1]-1..ij[1]+1)
      if matrix[i][j] == char && visited[i][j] != 1
        res << [i,j]
      end
    end
  end
  res
end
