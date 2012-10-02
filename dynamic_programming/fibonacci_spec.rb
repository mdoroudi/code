require_relative 'fibonacci'

describe "fibonacci recursive and DP" do
  it "Fibonacci 0 to be 0" do
    fibonacci_recursive(0).should eq 0
    fibonacci_dp(0).should eq 0
  end

  it "Fibonacci 1 to be 1" do
    fibonacci_recursive(1).should eq 1
    fibonacci_dp(1).should eq 1
  end

  it "Fibonacci 2 to be 1" do
    fibonacci_recursive(2).should eq 1
    fibonacci_dp(2).should eq 1
  end

  it "Fibonacci 3 to be 2" do
    number = 3
    res = 2
    fibonacci_recursive(number).should eq res
    fibonacci_dp(number).should eq res
  end

  it "Fibonacci 4 to be 3" do
    number = 4
    res = 3
    fibonacci_recursive(number).should eq res
    fibonacci_dp(number).should eq res
  end

  it "Fibonacci 5 to be 5" do
    number = 5
    res = 5
    fibonacci_recursive(number).should eq res
    fibonacci_dp(number).should eq res
  end

  it "Fibonacci 6 to be 8" do
    number = 6
    res = 8
    fibonacci_recursive(number).should eq res
    fibonacci_dp(number).should eq res
  end
end
