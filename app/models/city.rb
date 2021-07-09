class City < ApplicationRecord

    alias_attribute :name, :cityName

    validates :cityName , presence: true

    def self.find_city(city)
        find_by(cityName: city)
    end
end
