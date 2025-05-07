class MoviesController < ApplicationController
  def index
    # there might be a more performant way of doing this.
    @movies = Movie.find(Movie.ids.sample(3))
  end
end
