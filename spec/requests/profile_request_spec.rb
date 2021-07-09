require 'rails_helper'

RSpec.describe 'ProfilesController', type: :request do
    before do
        @user = create(:user)
    end
    context "GET #show" do
        it 'renders profile page' do 
            sign_in @user
            get profile_path(@user)
            expect(response).to be_successful
        end
    end
    context "GET #edit" do
        it 'renders edit page' do 
            sign_in @user
            get edit_profile_path(@user)
            expect(response).to be_successful
        end
        it 'other than current user and admin other cant edit' do 
            sign_in @user
            @user1 = create(:user , email:'kri@gmail.com')
            get edit_profile_path(@user1)
            expect(response).not_to be_successful
        end
    end
    context "POST #update" do
        it 'renders edit page' do 
            sign_in @user
            put profile_path(@user) , params: { user: {name:"new", mobNumber:"8765434567", address:"new ad"}}
            expect(response).to redirect_to(profile_path(@user))
        end
        it 'other than current user and admin cannott update' do 
            sign_in @user
            @user1 = create(:user , email:'kri@gmail.com')
            put profile_path(@user1), params: { user: {name:"new", mobNumber:"8765434567", address:"new ad"}}
            expect(response).not_to redirect_to(profile_path(@user))
        end
    end
    context "DELETE #destroy" do
        it 'destroy current user' do 
            sign_in @user
            delete profile_path(@user)
            expect(response.status).to eq(302)
        end
    end

end