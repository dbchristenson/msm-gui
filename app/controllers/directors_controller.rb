class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def insert
    director = Director.new
    director.name = params.fetch("query_name")
    director.dob = params.fetch("query_dob")
    director.bio = params.fetch("query_bio")
    director.image = params.fetch("query_image")

    if director.save
      redirect_to("/directors", { :notice => "Director added successfully." })
    else
      redirect_to("/insert_director", { :alert => "Failed to add director." })
    end
  end

  def modify
    the_id = params.fetch("path_id")
    director = Director.where({ :id => the_id }).first
    director.name = params.fetch("query_name")
    director.dob = params.fetch("query_dob")
    director.bio = params.fetch("query_bio")
    director.image = params.fetch("query_image")

    if director.save
      redirect_to("/directors/#{director.id}", { :notice => "Director updated successfully." })
    else
      redirect_to("/modify_director/#{director.id}", { :alert => "Failed to update director." })
    end
  end

  def delete
    the_id = params.fetch("path_id")
    director = Director.where({ :id => the_id }).first

    if director.destroy
      redirect_to("/directors", { :notice => "Director deleted successfully." })
    else
      redirect_to("/directors", { :alert => "Failed to delete director." })
    end
  end
end
