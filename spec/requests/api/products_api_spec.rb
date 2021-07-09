require 'rails_helper'

RSpec.describe 'Api::V1::ProductsController', type: :request do

    let(:oath_app) { Doorkeeper::Application.create!(name:'rspecTesting') }
    let(:access_token) { Doorkeeper::AccessToken.create!(application: oath_app) }
    let(:authorization) { "Bearer #{access_token.token}" }
    before do
        @user = create(:user)
        @brand = create(:brand)
        @product = create(:product , user_id: @user.id , brand_id: @brand.id)
    end
    
    let(:prod1) do 
        { name:'product 1',category: 'other',description: 'rspec',price:200 }
    end
    let(:prod1_updated) do 
        { name:'product 1',category: 'vehicles',description: 'rspec',price:200, user_id:1 }
    end
    
    context 'GET #myProducts' do
        it 'returns products successfully' do
            get '/api/v1/my_products', headers: { Authorization: authorization } 
            expect(response.body).to include(@product.to_json)
        end
    end

    context 'GET #index' do
        it 'returns products successfully' do
            get api_v1_products_path , headers: { Authorization: authorization }
            expect(response).to be_successful
        end
    end

    context 'GET #show' do
        it 'returns product successfully' do
            get api_v1_product_path(@product) , headers: { Authorization: authorization }
            expect(response).to be_successful
            expect(response.body).to include(@product.to_json)

        end
    end

    context 'POST #create' do
        it 'product created successfully' do
            post api_v1_products_path , headers: { Authorization: authorization } , params: prod1
            expect(response).to be_successful
        end
    end

    context 'PUT #update' do
        it 'product updated successfully' do
            put api_v1_product_path(@product) , headers: { Authorization: authorization } , params: prod1_updated
            expect(response).to be_successful
        end
    end

    context 'DELETE #destroy' do
        it 'product deleted successfully' do
            delete api_v1_product_path(@product) , headers: { Authorization: authorization }
            expect(response).to be_successful
        end
    end

end