class Category < ApplicationRecord
    has_and_belongs_to_many :products , foreign_key: 'category_id'
end
