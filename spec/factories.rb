FactoryBot.define do
    factory :user do
        email { 'gok@gmail.com' }
        password { 'password' }
        password_confirmation { 'password' }  
        name {'test'}
        address {'address'}
        mobNumber {'9876567890'}      
    end

    factory :product do
        name {'product name'}
        category {'other'}
        description {'rspec'}
        price {200}  
        user_id {}      
    end
end