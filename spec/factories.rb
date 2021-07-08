FactoryBot.define do
  factory :brand do
    brandName { "MyString" }
  end

  factory :category do
    category { "MyString" }
  end

  factory :country do
    countryName { "MyString" }
  end

  factory :state do
    stateName { "MyString" }
  end

  factory :city do
    cityName { "MyString" }
  end

  factory :favourite do
    user { nil }
    product { nil }
  end

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
        description {'rspec'}
        price {200}  
        user_id {}   
        brand_id {}   
    end
end