require 'debugger'
# This code implements a max binary heap
# heaps are used in: Dijkstra lagorithm and sorting algorithm heapsort, Prims minimal spannign tree

class Heap < Array 

  def initialize
    []
  end

  def create
    self.initialize
  end

  def max
    self[0] if self.size > 0
  end

  def insert(item)
    self << item
    self.max_heapify_bottom_up( self.size - 1 )
  end

  def left_i(index)
    left = index*2
  end

  def right_i(index)
    right = index*2 + 1 
  end

  def parent_i(index)
    index > 0 ? ((index/2.0).ceil - 1) : nil
  end

  def height
   log2(self.size) 
  end

  def delete_max

  end

  # if element at the end of the array is larger than the parents above
  def max_heapify_bottom_up(index)
    if parent_i(index) && self[parent_i(index)] < self[index]    
      self.swap(parent_i(index), index)
      max_heapify(parent_i(index))
    end
  end

  # if element is on top or in the middle and is smaller than it's children
  def max_heapify_top_down(index)

    if self[self.right_i(index)]
      if self[self.right_i(index)] > self[index]
        larger_i = self.right_i(index)
      else
        larger_i = index
      end
    end

    if self[self.left_i(index)]
      if self[self.left_i(index)] > self[index]
        larger_i = self.left_i(index)
      end
    end

    larger_i = index if larger_i.nil?

    if larger_i != index
      self.swap(larger_i, index)
      max_heapify(larger_i)
    else
      return
    end
    
  end

  def swap(i_1, i_2)
    tmp = self[i_1]
    self[i_1] = self[i_2]
    self[i_2] = tmp
  end

  # index is an index that is not at the right place
  def max_heapify(index)
    if parent_i(index) && self[parent_i(index)] < self[index]    
      self.max_heapify_bottom_up(index)
    else
      self.max_heapify_top_down(index)
    end
  end

  def heap_sort
    last_i = self.size - 1
    self.swap(0, last_i)
  end
  
  # merge two heaps together
  def merge(secon_heap)
  end
end

heap  = Heap.new
array = [1,12,11,9,3, 20, 0, 20]
puts array
array.each do |i|
  heap.insert(i)
end
puts "-----------------------"
puts heap 
