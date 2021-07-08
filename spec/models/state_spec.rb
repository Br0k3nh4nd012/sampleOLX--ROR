require 'rails_helper'

RSpec.describe State, type: :model do
  

  context "validations" do
    it 'should save successfully' do
      # prod = @user.products.new(name:'product name',category: 'other',description: 'rspec',price: 200)
      # expect { prod.save! }.to raise_error(ActiveRecord::RecordInvalid) 
      state = build(:state)
      expect(state.save).to eq true
    end
    it 'should not save successfully' do
      # prod = @user.products.new(name:'product name',category: 'other',description: 'rspec',price: 200)
      # expect { prod.save! }.to raise_error(ActiveRecord::RecordInvalid) 
      state = build(:state, stateName: '')
      expect(state.save).to eq false
    end
  end
end
