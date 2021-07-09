require 'rails_helper'

RSpec.describe 'ProductsController', type: :request do
    before do
        @user = create(:user)
        @user1 = create(:user , email:'kri@gmail.com')
        @brand = create(:brand)
        @category = create_list(:category , 2)
    end

    let(:prod1) do 
        { name:'product 1',description: 'rspec',price:200 , brand_id: @brand.id}
    end
    let(:prod1_updated) do 
        { name:'product 1',description: 'rspec',price:200, user_id:1 , brand: @brand.brandName }
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
            prod = create(:product , user_id: @user.id, brand_id: @brand.id)
            get product_path(prod)
            expect(response).to be_successful
        end
        it 'not returns a success response if not auth' do
            # prod = @user.products.create(prod1)
            prod = create(:product , user_id: @user.id, brand_id: @brand.id)
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

    context 'GET #edit' do
        it 'renders edit page success' do
            sign_in @user
            # allow(controller).to receive(:categories) {Category.pluck(:category)}
            prod = create(:product , user_id: @user.id , brand_id: @brand.id)
            get edit_product_path(prod)
            expect(response.status).to eq(200)
        end
    end

    context '#searchedProducts' do
        it 'get search products page' do
            sign_in @user
            # prod = create(:product , user_id: @user.id , brand_id: @brand.id)
            get searched_products_path
            expect(response.status).to eq(302)
        end
        it 'find products based on inputs' do
            sign_in @user
            prod = create(:product , user_id: @user.id , brand_id: @brand.id)
            post searched_products_path , params: { search: { value: prod.name}}
            expect(response.status).to eq(200)
        end
    end

    context 'POST Favourites' do
        it 'adds favourite' do
            sign_in @user
            @product = create(:product , user_id: @user1.id, brand_id: @brand.id)  
            post add_favourites_path(@product)           
            expect(response.status).to eq(302)
        end
        it 'remove favourite' do
            sign_in @user
            @product = create(:product , user_id: @user1.id, brand_id: @brand.id)  
            @user.favourites.new(product_id:@product.id).save
            post remove_favourites_path(@product)           
            expect(response.status).to eq(302)
        end
    end

    context 'PUT #update' do
        it 'updates a product successfully' do
            sign_in @user
            # prod = @user.products.create(prod1)
            prod = create(:product , user_id: @user.id , brand_id: @brand.id)            
            put product_path(prod), params: {id:prod.id, product: prod1_updated }            
            expect(response).to redirect_to(prod)
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

    context 'POST #create' do
        it 'creates a product successfully' do
            sign_in @user   
            
            post products_path , params: { product: {name:"test" , description:"TEst", brand: @brand.brandName ,category: @category, price:234 } } 
            expect(response).to redirect_to(new_product_location_path(Product.last))
            # expect(response.body.to_json).to eq("fsfrgvfdv")
        end
    end
end

