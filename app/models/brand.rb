class Brand < ApplicationRecord

    alias_attribute :name, :brandName
    has_many :products

    default_scope { order(:brandName) }
end
