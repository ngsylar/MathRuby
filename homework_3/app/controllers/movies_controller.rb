class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  # def all_ratings
  #   %w(G PG PG-13 NC-17 R)
  # end
  
  def index
    params.permit!
    sort = params[:sort_by] || 'title'
    @movies = Movie.all.order(sort)
    @all_ratings = Movie.all_ratings
    @all_ratings.append('hidden')

    session[:sort_by] = params[:sort_by] || session[:sort_by] || 'title'
    sort_param = session[:sort_by]

    session[:ratings] = params[:ratings] || session[:ratings] || @all_ratings.zip([]).to_h
    @rating_filter = session[:ratings].keys

    @movies = Movie.where(rating: @rating_filter).order(sort_param)
  end

  def new
    # default: render 'new' template
  end

  def create
    params.permit!
    @movie = Movie.create!(params[:movie])
    # Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    params.permit!
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
