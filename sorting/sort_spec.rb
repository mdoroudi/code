require 'debugger' 
require_relative 'sort'

describe :quick_sort do
  it "should sort an array" do
    quick_sort([3,0]).should eq [0,3]
  end

  it "should return empty for an emtpy array" do
    quick_sort([]).should eq []
  end

  it "should return same for array fo size 1" do
    quick_sort([1]).should eq [1]
  end

  it "should sort correctly an array with dups" do
    quick_sort([10,9,3,10,8]).should eq [3,8,9,10,10]
  end
end
