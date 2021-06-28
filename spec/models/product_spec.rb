require 'rails_helper'

RSpec.describe 'Product' ,type: :model do
    context 'validations' do
        before {@user = User.create!(email:'gok@gmail.com',password:'password',password_confirmation:'password')}
        it 'should save successfully' do
            prod = @user.products.new(name:'product name',category: 'other',description: 'rspec',price: 200)
            # expect { prod.save! }.to raise_error(ActiveRecord::RecordInvalid) 
            expect(prod.save).to eq true
        end
        it 'should not save, name missing!' do
            # user = User.create!(params)
            prod = @user.products.new(category: 'other',description: 'rspec',price: 200)
            expect(prod.save).to eq false
        end
        it 'should not save, category missing!' do
            prod = @user.products.new(name:'productname',description: 'rspec',price: 200)
            expect(prod.save).to eq false
        end
        it 'should not save, price missing!' do
            prod = @user.products.new(name:'product name',category: 'other',description: 'rspec')
            expect(prod.save).to eq false
        end
        it 'should not save, price invalid!' do
            prod = @user.products.new(name:'product name',category: 'other',description: 'rspec',price:-20)
            expect(prod.save).to eq false
        end
    end

    context 'testing scopes' do
        let(:user1) {User.create!(email:'gok@gmail.com',password:'password',password_confirmation:'password')}
        let(:user2) {User.create!(email:'kri@gmail.com',password:'password',password_confirmation:'password')}
        before do
            user1.products.new(name:'product 1',category: 'other',description: 'rspec',price:200).save
            user1.products.new(name:'product 2',category:'mobile',description: 'rspec',price:208).save
            user1.products.new(name:'product 3',category: 'other',description: 'rspec',price:120).save
            user2.products.new(name:'product 4',category: 'laptop',description: 'rspec',price:120).save
            user2.products.new(name:'product 4',category: 'other',description: 'rspec',price:120).save
        end

        it 'other products than products of current user' do
            expect(Product.other_products(user2).size).to eq(3)
        end
        it 'other products than products of current user' do
            expect(Product.other_products(user1).size).to eq(2)
        end
    end

    
     
end

# RSpec.describe 'ProductsController' , type: :controller do
#     context 'GET #index' do
#             it 'returns a success responce' do 
#                 get :index
#                 expect(response).to be_success                
#             end
#         end
# end