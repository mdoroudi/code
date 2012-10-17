require 'debugger'
require_relative 'apartment_snippet_generator'

describe :TextSnippetGenerator do 
  let (:document) { "Our luxury loft-style apartments were constructed as condominiums, so your new residence will have: Solid floors and walls (this will be the quietest apartment you've EVER lived in); Premium stainless steel designer appliances; Distinctive accent walls and hardwood flooring; A kitchen that most chefs would drool over with easy to clean gas stove and countertops; Walk in closets with built in storage; Full size washer and dryer in each apartment home. In addition, all residents will enjoy use of our top-notch amenities, including reserved parking, cutting-edge fitness center, wireless internet cafe/business center, and rooftop lounge to soak up the sun! highly desirable location; two car parking; parking garage; guest parking" }

  before (:each) do
    @subject = TextSnippetGenerator.new 
    @subject.stub(:synonyms).and_return([]) 
    @subject.stub(:hypernyms).and_return([])  
  end

  describe :snippets do
    it "should return one result for 'kitchen'" do
      @subject.snippets(document, "kitchen").size.should eq 1
    end

    it "should return one result for two 'kitchen' search" do
      @subject.snippets(document, "kitchen Kitchen").size.should eq 1
    end

    it "should return two results for 'hardwood floor'" do
      @subject.snippets(document, "hardwood floor").size.should eq 2
    end

    it "should show the results with more hits first " do
      expected = 'walls and hardwood flooring'
      @subject.snippets(document, "hardwood floor").first.should match /#{expected}/
    end

    it "should show the result with less hits next" do
      expected = 'Solid floors and walls'
      @subject.snippets(document, "hardwood floor")[1].should match /#{expected}/
    end

    it "should return no result for bad search" do
      @subject.snippets(document, 'foo').size.should eq 0
    end

    it "should return at most MAX_RESULTS number of results" do
      @subject.snippets(document, 'parking').size.should eq @subject.max_results
    end

    describe :singularize do
      it "should singularize floors the word if it gets more results out of it" do
        @subject.snippets(document, 'floors').size.should eq 2
      end
    end
  end

  describe :snippet_paragraph do
    it "should return an empty paragrpah for bad search" do
      @subject.snippet_paragraph(document, 'foo').size.should eq 0
    end

    it "should return a non-empty paragraph for existing snippets" do
      @subject.snippet_paragraph(document, 'hardwood floor').size.should > 1
    end
  end

  describe :generate_all_snippets do
    it "should return more results than max if there are any" do
      @subject.generate_all_snippets(document, 'parking').size.should > @subject.max_results
    end
  end

end
