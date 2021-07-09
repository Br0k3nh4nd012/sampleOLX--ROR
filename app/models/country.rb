class Country < ApplicationRecord

    alias_attribute :name, :countryName


    validates :countryName , presence: true

    def self.find_country(country)
        find_by(countryName: country)
    end
end
