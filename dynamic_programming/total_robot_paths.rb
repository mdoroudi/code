# A robot has to move in a MxN matrix from (M,N) to (0,0)
# it can either go up or right
# find unique number of paths from M,N to 0,0
# Also find unique number of paths from each point to 0,0

# math form:
# path(0,0) = 0
# path(0,i) = 1
# path(i,0) = 1
# path(i, j) = path(i-1,j) + path(i, j-1)
#
# total times
# (m-1 + n-1)!/(n-1)!(m-1)!

def calculate_total_paths(m,n)
  return 1 if m == 1 and n == 1
  paths = []
  for i in (0..m)
    paths << Array.new(0,n)
  end

  # initialze borders
  for j in (0...n)
    paths[0][j] = 1
  end

  for i in (0...m)
    paths[i][0] = 1
  end

  paths[0][0] = 0

  for i in (1...m)
    for j in (1...n)
      paths[i][j] = paths[i][j-1] + paths[i-1][j]
    end
  end
  paths[m-1][n-1]
end
