module MoviesHelper

  def highlight_highest_rated(current_rating, highest_rating)
    # This method doesn't take into account tied movies. To handle tied movies, the movie id should be the params here.
    current_rating == highest_rating ? "bg-green-300" : nil
  end
end
