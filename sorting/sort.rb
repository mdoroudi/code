require_relative '../heap/heap'
def quick_sort(array)
  return array if array.size < 2

  piv_index = rand(0...array.size)
  pivot = array[piv_index]

  arr_smaller = []
  arr_larger = []

  array.each_with_index do |item, index|
    next if index == piv_index
    arr_smaller << item if item < pivot
    arr_larger << item if item >= pivot
  end
  
  # if you dont' pass the pivot here then in the case of array.size two it can get stock in an infinite loop
  return quick_sort(arr_smaller) + [pivot] + quick_sort(arr_larger)
end

# this has been defined as part of heap.rb
def heap_sort(array)
  heap = Heap.new(array)
  heap.heap_sort
end

def merge_sort(array)
  size = array.size
  return array if size <= 1 

  left = merge_sort(array[0...(size/2)])
  right = merge_sort(array[(size/2)...size])

  if left[left.size - 1] < right[0]
    return left + right
  else
    return merge(left, right)
  end

end


# helper for merge_sort
def merge(arr1, arr2)
  return arr1 if arr2.empty?
  return arr2 if arr1.empty?

  result = []
  i1 = 0
  i2 = 0
  while (arr1[i1] && arr2[i2])
    if arr1[i1] > arr2[i2]
      result << arr2[i2]
      i2 += 1 
    else
      result << arr1[i1]
      i1 += 1
    end
  end
 
  return result.concat(arr2[i2...(arr2.size)]) if arr1[i1].nil?
  return result.concat(arr1[i1...(arr1.size)]) if arr2[i2].nil?

end

# Very good for arrays that are almost sorted, complexity would be O(n+d) where d is number of items out of place
# efficient for array with fewer than 10 elements
def insertion_sort(array)
  return array if array.size < 2 

  for k in (1...array.size)
    for i in (0...k)
      if array[i] > array[k]
        swap(array, i, k)
      end  
    end
  end
  array
end

def insertion_sort_more_efficient(array)
  return array if array.size < 2

  for k in (1...array.size)
    index = k - 1
    while index >= 0 and array[index] > array[index+1]
      swap(array, index, index+1)
      index -= 1
    end
  end
  array
end

def swap(array, i, j)
  tmp = array[i]
  array[i] = array[j]
  array[j] = tmp
end

def bubble_sort(array)
  total_iterations = array.size
  total_iterations.times do |i|
    for j in (0...total_iterations-1) 
      if array[j] > array[j+1]
        swap(array, j, j+1)
      end
    end
  end
  array
end



##### COUNTING SORT #####

def counting_sort(array, max)
  return array if array.size < 2 
  positions = Array.new(max + 1, 0) 
  result = Array.new(array.size)

  array.each do |item|
    positions[item] = positions[item] + 1
  end
  for i in (1...positions.size)
    positions[i] = positions[i-1] + positions[i]
  end

  array.each_with_index do |item, index|
    result[positions[item] - 1] = item 
    positions[item] -= 1
  end

  return result
end


def bucket_sort(array, min, max)
  return array if array.size < 2

  b_size = 10
  # if we instanciate this with [] it instanciat eit with the same object
  # then when we insert to on of the indeces it inserts to all
  bucket = Array.new((max - min + 1)/b_size + 1)
  array.each do |a|
    if bucket[a/b_size].nil?
      bucket[a/b_size] = [a]
    else
      bucket[a/b_size] << a
    end
  end

  bucket.each do |b|
    insertion_sort_more_efficient(b)
  end
  
  bucket.flatten
end
