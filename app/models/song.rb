class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def slug
        self.name.split.map { |part| part.downcase }.join("-")
    end

    def self.find_by_slug(slug)
        unslugifed = slug.split("-").map { |part| part.capitalize }.join(" ")
        self.find_by_name(unslugifed)
    end

end