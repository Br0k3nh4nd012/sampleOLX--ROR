class State < ApplicationRecord

    alias_attribute :name, :stateName

    validates :stateName , presence: true
end
