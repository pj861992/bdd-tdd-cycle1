require 'spec_helper'

describe MoviesController do

	let(:valid_attributes) { { :title => "Teste" , :rating =>"PG", :description=>"A" , :release_date =>"B",
														:director => "The" } }

	let(:invalid_attributes) { { :title => "Teste" , :rating =>"PG", :description=>"A" , :release_date =>"B" } }


	describe ' Create movies in database' do 

		it 'should be create movies' do
			  post :create, {:movie => valid_attributes}
        expect(assigns(:movie)).to be_a(Movie)
        expect(assigns(:movie)).to be_persisted
		end 

		it 'should redirect to movies_path' do
  		  post :create, {:movie => valid_attributes}
			 expect(response).to redirect_to(movies_path)
		end

	end


	describe 'Add director to existing movie' do

	  	it 'When I go to the edit page for "Alien"' do 
    	  movie = Movie.create! valid_attributes
	      get :edit, {:id => movie.to_param}	
	      expect(assigns(:movie)).to eq(movie)
	  	end
	end


	describe 'Order the movies ' do
			
	    it 'should redirect if sort order has been changed' do
	      
	      get :index, {:ratings => {:G => 1},:sort => 'title'}
	       expect(response).to redirect_to(movies_path(:ratings => {:G => 1},:sort => 'title'))
	    end
	
	    it 'should be possible to order by release date' do
	      get :index, {:ratings => {:G => 1},:sort => 'release_date'}
	      expect(response).to  redirect_to(movies_path(:ratings => {:G => 1},:sort => 'release_date'))
	    end
	
	    it 'should redirect if selected ratings are changed' do
	      get :index, {:ratings => {:G => 1}}
	      expect(response).to  redirect_to(movies_path(:ratings => {:G => 1}))
	    end 
	end


	describe 'Find movies by same director' do

	  it 'When I go to the show page for "Alien"' do 
		movie = Movie.create! valid_attributes
      	get :same, {:id => movie.to_param}	
      	expect(assigns(:movie)).to eq(movie)
  	  end

  	  it ' I should be on the Similar Movies page for the Movie' do
      	double = double('Movie')
      	double.stub(:director).and_return('double director')
      
      	similarDouble = [double('Movie'), double('Movie')]
      
      	Movie.should_receive(:find).with('13').and_return(double)
      	Movie.should_receive(:find_all_by_director).with(double.director).and_return(similarDouble)
      	get :same, {:id => '13'}
      end

	end

	describe 'When Director is blank' do

	  it 'When I go to the same movies page ' do 
		movie = Movie.create! invalid_attributes
      	get :same, {:id => movie.to_param}	
      	expect(assigns(:movie)).to eq(movie)
  	  end
  	  

	  it ' shoud be redirect to movie_path' do 
		movie = Movie.create! invalid_attributes
      	get :same, {:id => movie.to_param}	
      	 expect(response).to redirect_to(movies_path)

  	  end

  	  it 'should  get index and get a  session' do
      		session[:director_blank] = 'test'
      		get :index
      		session[:director_blank].should == 'test'
    	end
	end

  describe "GET show movies" do
    it "should get the movies" do
      movies = Movie.create! valid_attributes
      get :show, {:id => movies.to_param}
      expect(Movie.last).to eq(movies)
    end
  end

	describe "Update movies" do

	  it "should redirects to the reclamacao" do
        movies = Movie.create! valid_attributes
        put :update, {:id => movies.to_param, :movie => valid_attributes}
        expect(response).to redirect_to(movie_path(movies))
      end

       it "should updates the requested reclamacao" do
        movies = Movie.create! valid_attributes
        put :update, {:id => movies.to_param, :movie => valid_attributes}
        movies.reload
        expect(Movie.last).to eq(movies)
      end
	end

	describe "DELETE destroy" do
	    
		it "destroys the requested reclamacao" do
	      movie = Movie.create!
	      expect {
	        delete :destroy, {:id => movie.to_param}
	      }.to change(Movie, :count).by(-1)
	    end
	end

end