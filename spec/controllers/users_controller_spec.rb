require 'rails_helper'

RSpec.describe UsersController, type: :controller do
   fixtures :users
     setup do
        sign_in users(:user1)
     end
    describe 'GET index'do
        it 'checks for status 302'do
            sign_out :user
            get :index
            expect(response).to have_http_status(:found)
        end

        it 'gets index' do
            expect(response).to have_http_status(:ok)
        end
    end

    describe "GET show" do
        it "returns status ok for show action" do
            get :show, params: {:id => users(:user1)}
            expect(response).to have_http_status(:ok)
        end
        
        it "returns status found for show action" do
            sign_out :user
            get :show, params: {:id => users(:user1)}
            expect(response).to have_http_status(:found)
        end
    end

end
