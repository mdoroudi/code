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
