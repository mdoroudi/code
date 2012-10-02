require 'debugger'
require_relative 'block_with_largest_sum'

describe "Block of Largest sum" do

  describe "1 dimentional Arrays" do
    it "should return all blocks with one for array of 1s" do
      array = [1,1,1,1,1,1]
      res = {l_sum: 6, start: 0, end: 5}
      array_largest_block(array).should eq res 
    end

    it "should add all the positive numbers of an array when all positive" do
      array = [1,2,3,4,5,6,7]
      res = {l_sum: 28, start: 0, end: 6}
      array_largest_block(array).should eq res
    end

    it "should add the middle block" do
      array = [-1, 1, 2, -1]
      res = {l_sum: 3, start: 1, end: 2}
      array_largest_block(array).should eq res
    end

    it "should add the single positive number" do
      array = [-1, -10, 2, -1]
      res = {l_sum: 2, start: 2, end: 2}
      array_largest_block(array).should eq res
    end

    it "should add the largest negative number" do
      array = [-1, -10, -2, -1]
      res = {l_sum: -1, start: 0, end: 0}
      array_largest_block(array).should eq res
    end
    
    it "should add the correct block" do
      array = [-1, 1, 2, -100, 100, -20, 10, 1,2]
      res = {l_sum: 100, start: 4, end: 4}
      array_largest_block(array).should eq res
    end

    it "should add the correct block" do
      array = [-1, 1, 2, -100, 100, -20, 10, 11,2]
      res = {l_sum: 103, start: 4, end: 8}
      array_largest_block(array).should eq res
    end

  end

end
