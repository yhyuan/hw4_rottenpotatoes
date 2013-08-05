require 'spec_helper'
describe Movie do
  describe "Find movies from the same director" do
    before(:each) do
      @movie = mock_model(Movie)
      Movie.stub!(:director).and_return("Apple") 
      Movie.stub!(:find).with("1").and_return(@movie) 
       
    end
    it "should find the director" do
      Movie.should_receive(:find).with("1").and_return(@movie) 
      Movie.findMoviesWithSameDirector("1")
    end
  end
end
