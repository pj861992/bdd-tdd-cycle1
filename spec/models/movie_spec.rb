require 'spec_helper'
include MoviesHelper

describe Movie do
  
  describe 'Find movies whose director matches' do

    it "Can be assigns" do

		Movie.new.should be_an_instance_of(Movie)
    	#pending "add some examples to (or delete) #{__FILE__}"

    end

    it ' assigns all ratings for  movie ' do

      movie = Movie.create
      movie = Movie.all_ratings
      movie.length.should == 5
    	#pending "add some examples to (or delete) #{__FILE__}"

    end

      it 'Find  id Movie by title  ' do

        Movie.create(title: "Lepo Lepo")
        expect(Movie.find_id_movie("Lepo Lepo")).to eq(Movie.last.id)
      #pending "add some examples to (or delete) #{__FILE__}"

    end


  end
    	#pending "add some examples to (or delete) #{__FILE__}"

end