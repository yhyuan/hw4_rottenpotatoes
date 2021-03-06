require 'spec_helper'
 
describe MoviesController, :type => :controller do
  before :each do
    @fake_movie = stub('double').as_null_object
    @movie = [mock('movie1')]
  end

describe 'displaying movies' do
    it 'should show detail of a movie' do
      get :show, {:id => 1}
      response.should render_template(:show)
      assigns(:movie).title.should == 'Aladdin'
    end
    
    context 'index' do
      it 'should redirect if params doesnt match with session' do
        get :index, {:ratings => {'PG'=>1, 'R'=>1}}
        response.should redirect_to movies_path(:ratings=>{'PG'=>1, 'R'=>1})
      end
      
      it 'should show movies ordered by title' do
        get :index, {:sort=>'title', :ratings => {'PG'=>1, 'R'=>1}}, {:sort=>'title', :ratings => {'PG'=>1, 'R'=>1}}
        assigns(:title_header).should == 'hilite'
        assigns(:date_header).should be_nil
        # response.should render_template(:index)
      end
      
      it 'should show movoies ordered by release date' do
        get :index, {:sort=>'release_date', :ratings => ['PG', 'R']}
        assigns(:date_header).should == 'hilite'
        assigns(:title_header).should be_nil
      end
    end
  end

  describe 'create a new movie' do
    it 'should render the new-movie template' do
      get :new
      response.should render_template 'new'
    end
    it 'should call a model method to persist data' do
      movie = stub('new movie').as_null_object
      Movie.should_receive(:create!).and_return(movie)

      post :create, {:movie => movie}
    end
    it 'should render home template' do
      movie = stub('new movie').as_null_object
      Movie.stub(:create!).and_return(movie)

      post :create, {:movie => movie}
      response.should redirect_to(movies_path)
    end
  end
  describe 'updating movie info' do
    before :each do
      movie_id = 5
      Movie.should_receive(:find).with(movie_id.to_s).and_return(@fake_movie)
      @fake_movie.should_receive(:update_attributes!).exactly 1
      put :update, {:id => movie_id, :movie => @movie}
    end
    it 'should call the model method that performs the movie update' do
      true
    end
    it 'should redirect to details template for rendering' do
      response.should redirect_to(movie_path @fake_movie)
    end
    it 'should make updated info available to template' do
      assigns(:movie).should == @fake_movie
    end
  end
  describe 'delete an existing movie' do
    it 'should render edit movie template' do
      Movie.stub(:find)
      get :edit, {:id => 5}
      response.should render_template 'edit'
    end
    it 'should call a model method to update data' do
      my_movie = mock('a movie').as_null_object

      Movie.should_receive(:find).and_return(my_movie)
      my_movie.should_receive(:destroy)

      delete :destroy, {:id => 1}
    end
    it 'should render show details template' do

    end
  end

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
      response.should render_template('director')
    end  
    it "should make the results available to that template" do
      get :director, {:id => 1}
      assigns(:movies_director).should == @movies
    end     
  end


end
