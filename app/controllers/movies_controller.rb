class MoviesController < ApplicationController
  def index
    # there might be a more performant way of doing this.
    @movies = Movie.find(Movie.ids.sample(3))
    @highest_rating = @movies.max_by(&:vote_average)&.vote_average
  end

  def search
    if params[:query].present?
      query = params[:query].to_s.strip
      displayed_ids = params[:displayed_movie_ids] || []
      @movies = Movie.where.not(id: displayed_ids).with_title_like(query)
    else
      @movies = Movie.none
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end
