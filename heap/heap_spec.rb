require 'debugger'
require_relative 'heap'

describe Heap do
  let (:heap) { Heap.new( [1,12,11,9, 20, 0, 3, 20] ) }
  subject { heap }
  
  describe :insert do
    it "should have parents larger or equal to the item, index 1" do
      index = 1
      heap[index].should be <= heap[heap.parent_i(index)]
    end

    it "should have parents larger or equal to the item, last index" do
      index = heap.size - 1
      heap[index].should be <= heap[heap.parent_i(index)]
    end

    it "should have parent larger than or equal to the item, index 3" do
      index = 3
      heap[index].should be <= heap[heap.parent_i(index)]
    end

    it "should have parent larger than or equal to the item, index 3" do
      index = 5
      heap[index].should be <= heap[heap.parent_i(index)]
    end
  end

  describe :parent_i do
    it "should have no parent for root of the heap" do
      heap.parent_i(0).should be nil
    end

    it "should have parent for index 1 of this heap" do
      heap.parent_i(1).should be 
    end

    it "should have parent for last index of this heap" do
      heap.parent_i(heap.size - 1).should be
    end

    it "should have the same parent for two children indeces" do
      heap.parent_i(1).should be heap.parent_i(2)
    end
  end


  describe :left_i do
    it 'should have the correct left index' do
      heap.left_i(0).should be 1
    end

    it 'should have the correct left index even if there is no item at that index' do
      heap.left_i(heap.size - 1).should be 15
    end
  end

  describe :right_i do
    it 'should have the correct right index' do
      heap.right_i(0).should be 2
    end

    it 'should have the correct right index even if there is no item at that index' do
      heap.right_i(heap.size - 1).should be 16
    end
  end

  its(:max) { should eq 20}
  its(:height) { should eq 3.0 }

  describe :heap_sort do
    it "shoud sort an empty array" do
      array = []
      heap = Heap.new(array)
      heap.heap_sort.should eq array
    end

    it "shoud sort a heap of size 1" do
      array = [1]
      heap = Heap.new(array)
      heap.heap_sort.should eq array
    end

    it "should sort an array of same items right" do
      array = [1,1,1,1,1,1]
      heap = Heap.new(array)
      heap.heap_sort.should eq array 
    end

    it "shoud sort an array with some duplicates right" do
      array = [7,5,6,7,0]
      heap = Heap.new(array)
      heap.heap_sort.should eq [0, 5,6,7,7]
    end

    it "shoud sort an array right" do
      array = [20,21,22,0,9,8]
      heap = Heap.new(array)
      heap.heap_sort.should eq [0,8,9,20,21,22]
    end
  end

  describe :merge do
    it "should merge two empty arrays right" do
      heap1 = Heap.new
      heap2 = Heap.new
      heap1.merge(heap2).should eq heap1
    end

    it "should merge an empty array with a non empty array" do
      heap1 = Heap.new
      heap2 = Heap.new([1])
      heap1.merge(heap2).should eq heap2
    end

    it "should merge two heaps of size 1" do
      heap1 = Heap.new([1])
      heap2 = Heap.new([3])
      heap1.merge(heap2).should eq Heap.new([1,3])
    end

    it "shoud merge two heaps together right" do
      arr1 = [10,42,5,6]
      arr2 = [43,0,1]
      heap1 = Heap.new(arr1)
      heap2 = Heap.new(arr2)
      heap1.merge(heap2).should eq Heap.new((arr1 + arr2))
    end
  end

end
