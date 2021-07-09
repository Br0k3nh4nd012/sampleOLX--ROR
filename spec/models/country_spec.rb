require 'rails_helper'

RSpec.describe Country, type: :model do
  
  context "validations" do
    it 'should save successfully' do
      country = build(:country)
      expect(country.save).to eq true
    end
    it 'should not save successfully' do
      country = build(:country, countryName: '')
      expect(country.save).to eq false
    end
  end

end
