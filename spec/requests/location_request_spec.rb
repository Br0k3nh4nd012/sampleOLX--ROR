require 'rails_helper'

RSpec.describe 'LocationsController', type: :request do
    before do
        @user = create(:user)
        @city = create(:city)
        @state = create(:state)
        @country = create(:country)
        @brand = create(:brand)
        @prod = create(:product, user_id: @user.id, brand_id:@brand.id)
    end

    context "GET #new" do
        it 'renders new page' do 
            sign_in @user
            get new_product_location_path(@prod)
            expect(response).to be_successful
        end
    end

    context "GET #edit" do
        it 'renders new page' do 
            sign_in @user
            loc = create(:location , city_id:@city.id,state_id: @state.id, country_id: @country.id, locatable_id: @prod.id , locatable_type: "Product" )
            get edit_product_location_path(product_id: @prod.id, id: loc.id)
            expect(response).to be_successful
        end
    end
    context "POST #create" do
        it 'created a location' do 
            sign_in @user
            
            post product_locations_path(@prod.id), params: {
                location: {
                    city: @city.cityName,
                    state: @state.stateName,
                    country: @country.countryName,
                    postalCode: 456787
                }
            }
            expect(response).to redirect_to(root_path)
        end
        it 'not create a location' do 
            sign_in @user
            
            post product_locations_path(@prod.id), params: {
                location: {
                    city: @city.cityName,
                    state: @state.stateName,
                    country: @country.countryName
                }
            }
            expect(response.status).not_to eq(302)
        end
    end

    context "PUT #update" do
        it 'updated a location' do 
            sign_in @user
            loc = create(:location , city_id:@city.id,state_id: @state.id, country_id: @country.id, locatable_id: @prod.id , locatable_type: "Product" )
            
            put product_location_path(product_id: @prod.id, id: loc.id), params: {
                location: {
                    postalCode: 455555
                }
            }
            expect(response).to be_successful
        end
    end
end