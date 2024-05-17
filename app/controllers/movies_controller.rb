class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def insert
    movie = Movie.new
    movie.title = params.fetch("query_title")
    movie.year = params.fetch("query_year")
    movie.description = params.fetch("query_description")
    movie.image = params.fetch("query_image")
    movie.director_id = params.fetch("query_director_id")

    if movie.save
      redirect_to("/movies", { :notice => "Movie added successfully." })
    else
      redirect_to("/insert_movie", { :alert => "Failed to add movie." })
    end
  end

  def modify
    the_id = params.fetch("path_id")
    movie = Movie.where({ :id => the_id }).first
    movie.title = params.fetch("query_title")
    movie.year = params.fetch("query_year")
    movie.description = params.fetch("query_description")
    movie.image = params.fetch("query_image")
    movie.director_id = params.fetch("query_director_id")

    if movie.save
      redirect_to("/movies/#{movie.id}", { :notice => "Movie updated successfully." })
    else
      redirect_to("/modify_movie/#{movie.id}", { :alert => "Failed to update movie." })
    end
  end

  def delete
    the_id = params.fetch("path_id")
    movie = Movie.where({ :id => the_id }).first

    if movie.destroy
      redirect_to("/movies", { :notice => "Movie deleted successfully." })
    else
      redirect_to("/movies", { :alert => "Failed to delete movie." })
    end
  end

end
