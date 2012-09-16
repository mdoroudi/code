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

end
