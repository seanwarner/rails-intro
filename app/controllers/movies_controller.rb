class MoviesController < ApplicationController

  def add_params_to_session(*args)
    args.each do |parameter|
      session[parameter] = params[parameter] unless params[parameter].nil?
    end
  end

  def perform_redirection(action, *args)
    redirect_hash = {:action=>action}
    do_redirect = false
    args.each do |key|
      do_redirect = true unless params[key] == session[key]
      redirect_hash[key] = session[key]
    end
    if do_redirect
      flash.keep if do_redirect
      redirect_to redirect_hash
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    add_params_to_session :ratings, :sort_by
    session[:ratings] = Movie.all_ratings_hash unless session[:ratings]

    @movies = Movie .order(session[:sort_by])
                    .where(:rating => session[:ratings].keys )
                    .all
    @all_ratings = Movie.all_ratings
    @filters = session[:ratings]

    perform_redirection 'index', :ratings, :sort_by
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
