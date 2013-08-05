class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.findMoviesWithSameDirector(id)
    director = Movie.find(id).director
    if(director == "")
      return ""
    else
      return Movie.find_all_by_director(director)
    end
  end
end
