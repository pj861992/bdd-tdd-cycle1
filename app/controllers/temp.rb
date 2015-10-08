def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def same

    @movie = Movie.find(params[:id])

    if @movie.director.blank?
       session[:director_blank] = @movie.title
       redirect_to movies_path
    else
    @movies_same_director = Movie.find_all_by_director(@movie.director)
    end
  end