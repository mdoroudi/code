require 'debugger'
# [[1,2,3]
#  [4,5,6]
#  [7,8,9]]
#
#  1
#  2,4
#  3,5,7
#  6,8
#  9
#
#  [0][0]
#  [0][1], [1][0]
#  [0][2], [1][1], [2][0]
#  [1][2], [2][1]
#  [2][2]
#
# go through every column of hte rown and for that get the diagon, that gives us half
# then go thgouh every row, and get the diagonal
def print_matrix_diagonal(matrix)
  n = matrix.size
  m = matrix[0].size

  for c in (0...m)
    j = c
    i = 0
    print_diagonal(i,j,n,matrix)
  end

  for r in (1...n)
    j = m - 1
    i = r
    print_diagonal(i,j,n,matrix)
  end

end

def print_diagonal(i,j,n,matrix)
  res = []
  while i < n && j >= 0 do
    res << matrix[i][j]
    i += 1
    j -= 1
  end
  puts res.to_s
end

puts "square 3x3 matfix"
matrix = [[1,2,3], 
          [4,5,6],
          [7,8,9]]
print_matrix_diagonal(matrix)

puts "rectangle 4x2 matrix"
matrix_vertical = [[1,2],
                   [3,4],
                   [5,6],
                   [7,8]]
print_matrix_diagonal(matrix_vertical)

puts "rectangle 2x4 matrix"
matrix_horizontal = [[1,2,3,4], 
                     [5,6,7,8]]
print_matrix_diagonal(matrix_horizontal)

puts "print 1xn matrix"
matrix = [[1,2,3,4]]
print_matrix_diagonal(matrix)

puts "print nx1 matrix"
matrix = [[1],[2],[3]]
print_matrix_diagonal(matrix)

