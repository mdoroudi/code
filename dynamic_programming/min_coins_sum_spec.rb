require 'debugger'
require_relative 'min_coins_sum'

describe "Dynamic Programming" do
  let (:coins) {[1, 5, 10, 25, 50]}
  describe :min_coins_sum do
    it "should return 0 for 0 cents" do
      min_coins_sum(0, coins).should eq 0 
    end
    
    it "should return 1 for 1 cents" do
      min_coins_sum(1, coins).should eq 1
    end
  
    it "should return 1 for 10 cents" do
       min_coins_sum(10, coins).should eq 1
    end

    it "should return 1 for 25 cents" do
       min_coins_sum(25, coins).should eq 1
    end

    it "should return 1 for 50 cents" do
       min_coins_sum(50, coins).should eq 1
    end

    it "should return 2 for 100 cents (1 dollar)" do
       min_coins_sum(100, coins).should eq 2
    end

    it "should return 2 for 2 cents" do
      min_coins_sum(2, coins).should eq 2
    end

    it "should return 3 for 12 cents" do
      min_coins_sum(12, coins).should eq 3
    end

    it "should return 3 for 11 cents" do
      min_coins_sum(11, coins).should eq 2
    end
  
    it "should return 3 for 101 cents" do
      min_coins_sum(101, coins).should eq 3
    end

    it "should return 2 for 15 cents" do
      min_coins_sum(15, coins).should eq 2
    end

    it "should return 4 for 17 cents" do
      min_coins_sum(17, coins).should eq 4
    end

  end
end

