class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs

    def slug
        self.name.split.map { |part| part.downcase }.join("-")
    end

    def self.find_by_slug(slug)
        unslugifed = slug.split("-").map { |part| part.capitalize }.join(" ")
        self.find_by_name(unslugifed)
    end

end