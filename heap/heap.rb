require 'debugger'
# This code implements a max binary heap
# heaps are used in: Dijkstra lagorithm and sorting algorithm heapsort, Prims minimal spannign tree

class Heap < Array 

  def initialize(array = nil)
    if array.nil?
      []
    else
      array.each do |i|
        self.insert(i)
      end
    end
  end

  def create(array = nil)
    self.initialize(array)
  end

  def max
    self[0] if self.size > 0
  end

  def insert(item)
    self << item
    self.max_heapify( self.size - 1 )
  end

  def left_i(index)
    left = index*2 + 1
  end

  def right_i(index)
    right = index*2 + 2 
  end

  def parent_i(index)
    index > 0 ? ((index/2.0).ceil - 1) : nil
  end

  def height
   Math.log2(self.size) 
  end

  def delete_max

  end

  def swap(i_1, i_2)
    tmp = self[i_1]
    self[i_1] = self[i_2]
    self[i_2] = tmp
  end

  # index is an index that is not at the right place
  def max_heapify(index)
    if self.left_i(index) > self.last_index && self.right_i(index) > self.last_index
      self.max_heapify_bottom_up(index)
    else
      self.max_heapify_top_down(index)
    end
  end

  def heap_sort
    @last_i = last_index() 
    self.swap(0, @last_i)
    @last_i =- 1
    self.max_heapify_top_down(0)
    self.heap_sort
  end
  
  # merge two heaps together
  def merge(secon_heap)
  end

  protected

  # if element at the end of the array is larger than the parents above
  def max_heapify_bottom_up(index)
    if parent_i(index) && self[parent_i(index)] < self[index]    
      self.swap(parent_i(index), index)
      max_heapify_bottom_up(parent_i(index))
    end
  end

  # if element is on top or in the middle and is smaller than it's children
  def max_heapify_top_down(index)

    if self.right_i(index) > self.last_index
      if self[self.right_i(index)] > self[index]
        larger_i = self.right_i(index)
      else
        larger_i = index
      end
    end

    if self.left_i(index) > self.last_index
      if self[self.left_i(index)] > self[index]
        larger_i = self.left_i(index)
      end
    end

    larger_i = index if larger_i.nil?

    if larger_i != index
      self.swap(larger_i, index)
      max_heapify_top_down(larger_i)
    else
      return
    end
    
  end

  def last_index
    @last_i || self.size - 1
  end
end

#heap  = Heap.new([1,12,11,9, 20, 0, 3, 20])
#puts heap.heap_sort
