require 'rails_helper'

RSpec.describe City, type: :model do
  
  context "validations" do
    it 'should save successfully' do
      city = build(:city)
      expect(city.save).to eq true
    end
    it 'should not save successfully' do
      city = build(:city, cityName: '')
      expect(city.save).to eq false
    end
  end

end
