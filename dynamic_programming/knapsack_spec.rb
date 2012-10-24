require_relative 'knapsack'

describe 'knapsack problem' do
  let (:items) { items = [{w: 10, p: 1}, {w: 3, p:14}, {w: 5, p: 5}, 
                          {w: 12, p: 30}, {w: 2, p: 10}, {w: 4, p: 2}] } 
  it "should return 0 price if the min weight in the set is larger than max" do    
    knap_sack(items, 1)[:price].should eq 0
  end

  it "should return 14 if weight is 3" do
    knap_sack(items, 3)[:price].should eq 14
  end

  it "should return 10 if weight is 2" do
    knap_sack(items, 2)[:price].should eq 10
  end

  it "should return 30 if weight is 6" do
    knap_sack(items, 3)[:price].should eq 14
  end

  it "should return 24 if weight is 5" do
    knap_sack(items, 5)[:price].should eq 24
  end
end
