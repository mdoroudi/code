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
