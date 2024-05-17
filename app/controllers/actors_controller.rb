class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert
    actor = Actor.new
    actor.name = params.fetch("query_name")
    actor.dob = params.fetch("query_dob")
    actor.bio = params.fetch("query_bio")
    actor.image = params.fetch("query_image")

    if actor.save
      redirect_to("/actors", { :notice => "Actor added successfully." })
    else
      redirect_to("/insert_actor", { :alert => "Failed to add actor." })
    end
  end

  def modify
    the_id = params.fetch("path_id")
    actor = Actor.where({ :id => the_id }).first
    actor.name = params.fetch("query_name")
    actor.dob = params.fetch("query_dob")
    actor.bio = params.fetch("query_bio")
    actor.image = params.fetch("query_image")

    if actor.save
      redirect_to("/actors/#{actor.id}", { :notice => "Actor updated successfully." })
    else
      redirect_to("/modify_actor/#{actor.id}", { :alert => "Failed to update actor." })
    end
  end

  def delete
    the_id = params.fetch("path_id")
    actor = Actor.where({ :id => the_id }).first

    if actor.destroy
      redirect_to("/actors", { :notice => "Actor deleted successfully." })
    else
      redirect_to("/actors", { :alert => "Failed to delete actor." })
    end
  end
end
