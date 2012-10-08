require 'debugger'
require_relative 'string_matching'

describe "string matchign problem" do
  describe :build_partial_match_table do
    it "should return a table with 0's because of no repeating words" do
      build_partial_match_table("mina").should eq [-1, 0, 0, 0]
    end

    it "should return an empty table for an empty word" do
      build_partial_match_table("").should eq []
    end

    it "should original table for a two letter repeating word, otherwise it keeps repeating itself" do
      build_partial_match_table("aa").should eq [-1, 0]
    end

    it "should return the right table for repeating abcabc" do
      build_partial_match_table("abcabc").should eq [-1, 0, 0, 0, 1, 2]
    end

    it "should return right table for multi repeating abcabcabc" do
      word = "abcabcabc"
      table =  [-1, 0, 0, 0, 1, 2, 3, 4, 5]
      build_partial_match_table(word).should eq table
    end

    it "should return right table for multi repeating abcabcabcccc" do
      word = "abcabcabcccc"
      table =  [-1, 0, 0, 0, 1, 2, 3, 4, 5, 6, 0, 0]
      build_partial_match_table(word).should eq table
    end

    it "should return right table for multi repeating abcabcabccccaa" do
      word = "abcabcabccccaa"
      table =  [-1, 0, 0, 0, 1, 2, 3, 4, 5, 6, 0, 0, 0, 1]
      build_partial_match_table(word).should eq table
    end

    it "should return right table for multi repeating abababababab" do
      word = "ababcabdabe"
      table = [-1, 0, 0, 1, 2, 0, 1, 2, 0, 1, 2] 
      build_partial_match_table(word).should eq table
    end
  end

  describe :search_string do
    it "shoudl match everything and there for index 0 for null word" do
      word, res = nil, 0
      search_string("hello", word).should eq res
    end

    it "should match nothing for empty text" do
      text, word, res = nil, "heloo", -1
      search_string(text, word).should eq res
    end

    it "should match nothing if text and word don't match" do
      text, word, res = "minador", "heloo", -1
      search_string(text, word).should eq res
    end

    it "should match nothing for word larger than text" do
      text, word, res = "oh", "heloo", -1
      search_string(text, word).should eq res
    end

    it "should return 10 for heloo match in ahelozzzzzheloommm" do
      text, word, res = "ahelozzzzzheloommm", "heloo", 10
      search_string(text, word).should eq res
    end

    it "should return 6 for search in abcabdabcdefabc for abcdef" do
      text, word, res = "abcabdabcdefabc", "abcdef", 6
      search_string(text, word).should eq res
    end      

    it "should return 10 for abcabc in 012abcabd9abcabcdef11111aaa" do
      text, word, res = "012abcabd9abcabcdef11111aaa", "abcabc", 10
      search_string(text, word).should eq res
    end


  end
end
