require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user)}
    let(:user_id) {user.id}

    before { host! "api.task-manager.test"}

    describe "GET /users/:id" do
        before do
            headers = { "Accept" => "application/vnd-taskmanager_v1"}
            get "/users/#{user_id}", params: {}, headers: headers
        end
    
        context "se o usuario existe" do
            it "retornar o usuario" do
                user_response = JSON.parse(response.body)
                expect(user_response["id"]).to eq(user_id)
            end
        end

        it "se esta retornando status 200" do
            expect(response).to have_http_status(200)
        end

        context "Se o usuario não existe..." do
            let(:user_id) {1000}
            it "Retornar um 404" do
                expect(response).to have_http_status(404)
            end
        end
    
    end


end