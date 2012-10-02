require 'debugger'
require_relative 'longest_increasing_subsequence'

describe DynamicProgramming do
  describe :longest_increasing_subsequence do
    it "should present the right LISS" do
      seq = [ 0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]
      DynamicProgramming.longest_increasing_subsequence(seq).should eq [0, 2, 6, 9, 11, 15]   
    end

    it "shoudl present the correct LISS for same numbers" do
      seq = [1,1,1,1]
       DynamicProgramming.longest_increasing_subsequence(seq).should eq [1,1,1,1]
    end

  end
end
