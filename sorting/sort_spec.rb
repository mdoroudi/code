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

  it "should return the same arrya with all duplicates" do
    quick_sort([1,1,1,1]).should eq [1,1,1,1]
  end
end

describe :heap_sort do
  it "should call heapsort correctly" do
    heap_sort([4,35,3,5]).should eq [3,4,5,35]
  end
end

describe :merge_sort do
  it "should sort an array" do
    merge_sort([3,0]).should eq [0,3]
  end

  it "should return empty for an emtpy array" do
    merge_sort([]).should eq []
  end

  it "should return same for array fo size 1" do
    merge_sort([1]).should eq [1]
  end

  it "should sort correctly an array with dups" do
    merge_sort([10,9,3,10,8]).should eq [3,8,9,10,10]
  end

  it "should return the same arrya with all duplicates" do
    merge_sort([1,1,1,1]).should eq [1,1,1,1]
  end
end

describe :insertion_sort do
  it "should sort an array" do
    insertion_sort([3,0]).should eq [0,3]
  end

  it "should return empty for an emtpy array" do
    insertion_sort([]).should eq []
  end

  it "should return same for array fo size 1" do
    insertion_sort([1]).should eq [1]
  end

  it "should sort correctly an array with dups" do
    insertion_sort([10,9,3,10,8]).should eq [3,8,9,10,10]
  end

  it "should return the same arrya with all duplicates" do
    insertion_sort([1,1,1,1]).should eq [1,1,1,1]
  end
end

describe :insertion_sort_more_efficient do
  it "should sort an array" do
    insertion_sort_more_efficient([3,0]).should eq [0,3]
  end

  it "should return empty for an emtpy array" do
    insertion_sort_more_efficient([]).should eq []
  end

  it "should return same for array fo size 1" do
    insertion_sort_more_efficient([1]).should eq [1]
  end

  it "should sort correctly an array with dups" do
    insertion_sort_more_efficient([10,9,3,10,8]).should eq [3,8,9,10,10]
  end

  it "should return the same arrya with all duplicates" do
    insertion_sort_more_efficient([1,1,1,1]).should eq [1,1,1,1]
  end
end

describe :bubble_sort do
  it "should sort an array" do
    bubble_sort([3,0]).should eq [0,3]
  end

  it "should return empty for an emtpy array" do
    bubble_sort([]).should eq []
  end

  it "should return same for array fo size 1" do
    bubble_sort([1]).should eq [1]
  end

  it "should sort correctly an array with dups" do
    bubble_sort([10,9,3,10,8]).should eq [3,8,9,10,10]
  end

  it "should return the same arrya with all duplicates" do
    bubble_sort([1,1,1,1]).should eq [1,1,1,1]
  end
end

describe :counting_sort do
  it "should sort an array" do
    counting_sort([3,0], 3).should eq [0,3]
  end

  it "should return empty for an emtpy array" do
    counting_sort([], 0).should eq []
  end

  it "should return same for array fo size 1" do
    counting_sort([1], 1).should eq [1]
  end

  it "should sort correctly an array with dups" do
    counting_sort([10,9,3,10,8], 10).should eq [3,8,9,10,10]
  end

  it "should return the same arrya with all duplicates" do
    counting_sort([1,1,1,1], 1).should eq [1,1,1,1]
  end
end


describe :bucket_sort do
  it "should sort an array" do
    bucket_sort([3,0], 0, 3).should eq [0,3]
  end

  it "should return empty for an emtpy array" do
    bucket_sort([], 0,0).should eq []
  end

  it "should return same for array fo size 1" do
    bucket_sort([1], 1,1).should eq [1]
  end

  it "should sort correctly an array with dups" do
    bucket_sort([10,9,3,10,8], 0, 10).should eq [3,8,9,10,10]
  end

  it "should return the same arrya with all duplicates" do
    bucket_sort([1,1,1,1], 1,1).should eq [1,1,1,1]
  end

  it "should easiry sort a big array" do
    array = [4,3,2,1,1,5,0,9,8,7,6,20,10,15]
    bucket_sort(array, 0, 20).should eq [0,1,1,2,3,4,5,6,7,8,9,10,15,20]
  end
end
