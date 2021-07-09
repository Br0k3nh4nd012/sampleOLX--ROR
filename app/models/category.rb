class Category < ApplicationRecord

    alias_attribute :name, :category

    has_and_belongs_to_many :products , foreign_key: 'category_id'

    default_scope { order(category: :asc) }


    def self.categories
        pluck(:category)
    end
end
