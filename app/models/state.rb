class State < ApplicationRecord

    alias_attribute :name, :stateName

    validates :stateName , presence: true

    def self.find_state(state)
        find_by(stateName: state)
    end
end
