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

    describe "POST /users" do
        before do
            headers = { 'Accept' => 'application/vnd.taskmanager.v1'}
            post '/users', params: { user: user_params }, headers: headers
        end

        context 'Quando os parametros da requisição forem válidos...' do
            # attributes_for é um método do FactoryGirl
            let(:user_params) { attributes_for(:user)}

            it 'Retornar 201' do
                expect(response).to have_http_status(201)
            end

            it 'Retornar um JSON com os dados do usuário criado' do
                user_response = JSON.parse(response.body)
                expect(user_response['email']).to eq(user_params[:email])
            end
        end

        context 'Quando os parametros d requisição forem inválidos...' do
            let(:user_params) { attributes_for(:user, email: 'lucas@@@')}

            it 'Retornar 422' do
                expect(response).to have_http_status(422)
            end

            it 'Retonar um JSON com os erros' do
                user_response = JSON.parse(response.body)
                expect(user_response).to have_key('errors')
            end
        end
    end

end