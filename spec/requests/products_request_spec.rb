require 'rails_helper'

RSpec.describe 'ProductsController', type: :request do
    before do
        @user = create(:user)
    end

    let(:prod1) do 
        { name:'product 1',category: 'other',description: 'rspec',price:200 }
    end
    let(:prod1_updated) do 
        { name:'product 1',category: 'vehicles',description: 'rspec',price:200, user_id:1 }
    end


    context 'GET #index' do
        it 'returns a success response if auth' do    
            sign_in @user             
            get products_path
            expect(response.status).to eq(200)         
        end
        it 'not returns a success response if not auth' do          
            get products_path
            expect(response.status).not_to eq(200)         
        end
    end

    context 'GET #show' do
        it 'returns a success response' do
            sign_in @user
            # prod = @user.products.create(prod1)
            prod = create(:product , user_id: @user.id)
            get product_path(prod)
            expect(response).to be_successful
        end
        it 'not returns a success response if not auth' do
            # prod = @user.products.create(prod1)
            prod = create(:product , user_id: @user.id)
            get product_path(prod)
            expect(response).not_to be_successful
        end
    end

    context 'GET #new' do
        it 'return a success response' do
            sign_in @user
            get new_product_path
            expect(response).to be_successful
        end
    end


    context 'POST #create' do
        it 'creates a product successfully' do
            sign_in @user          
            post products_path , params: { product: prod1 }
            expect(response).to be_successful
        end
    end

    context 'GET #edit' do
        it 'renders edit page success' do
            sign_in @user
            allow(controller).to receive(:checkUser) {true}
            prod = create(:product , user_id: @user.id )
            get edit_product_path(prod)
            expect(response.status).to eq(200)
        end
    end


    context 'PUT #update' do
        it 'updates a product successfully' do
            sign_in @user
            # prod = @user.products.create(prod1)
            prod = create(:product , user_id: @user.id )
            put product_path(prod), params: { product: prod1_updated }            
            expect(response).to redirect_to(@prod)
        end
    end

    context 'DELETE #destroy' do
        it 'product deleted successfully' do
            sign_in @user
            prod = @user.products.create(prod1)
            delete product_path(prod)         
            expect(response).to redirect_to(products_path)
        end
    end
end

