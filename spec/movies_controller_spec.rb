require 'spec_helper'
 
describe MoviesController, :type => :controller do
  describe "Find movies from the same director" do
    before(:each) do
      @movies = [mock_model(Movie), mock_model(Movie)]
      Movie.stub!(:findMoviesWithSameDirector).with("1").and_return(@movies) 
    end
    it "should find the director" do
      Movie.should_receive(:findMoviesWithSameDirector).with("1").and_return(@movies)
      get :director, {:id => 1}
    end
    it "should render the right template" do
      get :director, {:id => 1}
      response.should render_template('director')#redirect_to(movies_path + "/1/director")
    end  
    it "should make the results available to that template" do
      get :director, {:id => 1}
      assigns(:movies_director).should == @movies
    end     
  end
end
