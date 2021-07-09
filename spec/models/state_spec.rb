require 'rails_helper'

RSpec.describe State, type: :model do
  

  context "validations" do
    it 'should save successfully' do
      state = build(:state)
      expect(state.save).to eq true
    end
    it 'should not save successfully' do
      state = build(:state, stateName: '')
      expect(state.save).to eq false
    end
  end
end
