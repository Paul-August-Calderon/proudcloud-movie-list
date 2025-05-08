class MoviesController < ApplicationController
  def index
    # there might be a more performant way of doing this.
    @movies = Movie.find(Movie.ids.sample(3))
    @highest_rating = @movies.max_by(&:vote_average)&.vote_average
  end

  def search
    @movies = Movie.where("title LIKE ?", "%" + params[:query] + "%")
      respond_to do |format|
      format.turbo_stream
    end
  end
end
