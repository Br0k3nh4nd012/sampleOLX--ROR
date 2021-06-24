require 'rails_helper'

RSpec.describe 'Product' ,type: :model do
    context 'before creation' do
        it 'must contain user,name,category,price,description' do
            prod = Product.new(category:'other',description:'rspec',price:200)
            expect { prod.save! }.to raise_error(ActiveRecord::RecordInvalid) 
        end
    end
end
