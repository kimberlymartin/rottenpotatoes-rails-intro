class Movie < ActiveRecord::Base
    def self.all_ratings
        Movie.select(:rating).distinct.inject([]) {|ratings_array,m| ratings_array.push m.rating }
    end
end
