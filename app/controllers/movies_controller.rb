class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Set array of all the ratings
    @all_ratings = Movie.all_ratings

    # Set if movies will be sorted by title or release date
    @sort = params[:sort] || session[:sort]

    # Get only checked ratings
    session[:ratings] = session[:ratings] || @all_ratings
    #params[:ratings].nil? ? @ratings_param = @all_ratings : @ratings_param = params[:ratings].keys
    @ratings_param = params[:ratings] || session[:ratings]

    # Save session settings
    session[:sort] = @sort
    session[:ratings] = @ratings_param

    # Show sorted movies of the checked ratings
    @movies = Movie.where(rating: session[:ratings].keys).order(session[:sort])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
