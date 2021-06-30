require 'rails_helper'

RSpec.describe 'Product' ,type: :model do
    context 'validations' do
        before {@user = create(:user)}
        it 'should save successfully' do
            # prod = @user.products.new(name:'product name',category: 'other',description: 'rspec',price: 200)
            # expect { prod.save! }.to raise_error(ActiveRecord::RecordInvalid) 
            prod = build(:product , user_id: @user.id)
            expect(prod.save).to eq true
        end
        it 'should not save, name missing!' do
            # prod = @user.products.new(category: 'other',description: 'rspec',price: 200)
            prod = build(:product , user_id: @user.id, name: '')
            expect(prod.save).to eq false
        end
        it 'should not save, category missing!' do
            # prod = @user.products.new(name:'productname',description: 'rspec',price: 200)
            prod = build(:product , user_id: @user.id, category: '')
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
            # create(:product , user_id: user1.id)
            # create(:product , user_id: user1.id)
            # create(:product , user_id: user1.id)
            create_list(:product , 3, user_id: user1.id)
            create(:product , user_id: user2.id)
            create(:product , user_id: user2.id)
        end

        it 'other products than products of current user' do
            expect(Product.other_products(user2).size).to eq(3)
        end
        it 'other products than products of current user' do
            expect(Product.other_products(user1).size).to eq(2)
        end
    end

    
     
end
