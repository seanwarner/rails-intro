class MoviesController < ApplicationController
  def index
    session[:ratings] = params[:ratings]
    @movies = params[:ratings].nil?           ?
              Movie .order(params[:sort_by])
                    .all
                                              :
              Movie .order(params[:sort_by])
                    .where(:rating => params[:ratings].keys )
                    .all
    @all_ratings = Movie.all_ratings
    @filters = params[:ratings].nil?  ?  @all_ratings : params[:ratings]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
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
