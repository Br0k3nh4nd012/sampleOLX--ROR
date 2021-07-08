require 'rails_helper'

RSpec.describe 'Product' ,type: :model do
    context 'validations' do
        before {@user = create(:user)}
        before {@brand = create(:brand)}

        it 'should save successfully' do
            # prod = @user.products.new(name:'product name',category: 'other',description: 'rspec',price: 200)
            # expect { prod.save! }.to raise_error(ActiveRecord::RecordInvalid) 
            prod = build(:product , user_id: @user.id, brand_id: @brand.id)
            expect(prod.save).to eq true
        end
        it 'should not save, name missing!' do
            # prod = @user.products.new(category: 'other',description: 'rspec',price: 200)
            prod = build(:product , user_id: @user.id, name: '')
            expect(prod.save).to eq false
        end
        it 'should not save, price missing!' do
            # prod = @user.products.new(name:'product name',category: 'other',description: 'rspec')
            prod = build(:product , user_id: @user.id, price: nil)
            expect(prod.save).to eq false
        end
        it 'should not save, price invalid!' do
            # prod = @user.products.new(name:'product name',category: 'other',description: 'rspec',price:-20)
            prod = build(:product , user_id: @user.id, price: -20)
            expect(prod.save).to eq false
        end
    end

    context 'testing scopes' do
        let(:user1) {create(:user)}
        let(:user2) {create(:user , email:'kri@gmail.com')}
        before do
            @brand = create(:brand)
            # create(:product , user_id: user1.id)
            # create(:product , user_id: user1.id)
            # create(:product , user_id: user1.id)
            create_list(:product , 3, user_id: user1.id , brand_id: @brand.id)
            create(:product , user_id: user2.id , brand_id: @brand.id)
            create(:product , user_id: user2.id , brand_id: @brand.id)
        end

        it 'other products than products of current user' do
            expect(Product.other_products(user2).size).to eq(3)
        end
        it 'other products than products of current user' do
            expect(Product.other_products(user1).size).to eq(2)
        end
    end

    context 'testing methods' do
        before {@user = create(:user)}
        before {@brand = create(:brand)}
        let(:prod) {create(:product, user_id: @user.id , brand_id: @brand.id , )}
        before do
            @city = create(:city)
            @state = create(:state)
            @country = create(:country)
            prod.create_location()
        end
        it 'is city name' do            
            prod.location.city = @city
            expect(prod.location_city).to eq(@city.cityName)            
        end
        it 'is State name' do            
            prod.location.state = @state
            expect(prod.location_state).to eq(@state.stateName)            
        end
        it 'is State name' do            
            prod.location.country = @country
            expect(prod.location_country).to eq(@country.countryName)            
        end
        it 'is Brand name' do            
            prod.brand = @brand
            expect(prod.brandname).to eq(@brand.brandName)            
        end
    end
     
end
