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
  
  return quick_sort(arr_smaller) + [pivot] + quick_sort(arr_larger)
end
