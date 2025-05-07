module MoviesHelper

  def highlight_for_highest_rated_movie(current_vote, highest_vote)
    # This method doesn't take into account tied movies. To handle tied movies, the movie id should be the params here.
    current_vote == highest_vote ? "bg-green-300" : ""
  end
end
