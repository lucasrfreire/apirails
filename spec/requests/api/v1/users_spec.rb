require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user)}
    let(:user_id) {user.id}

    before { host! "api.task-manager.test"}

    describe "GET /users/:id" do
        before do
            headers = { "Accept" => "application/vnd.taskmanager.v1"}
            get "/users/#{user_id}", params: {}, headers: headers
        end
    
        context "se o usuario existe" do
            it "Retornar o usuário" do
                user_response = JSON.parse(response.body)
                expect(user_response["id"]).to eq(user_id)
            end

            it "Retornar 200" do
                expect(response).to have_http_status(200)
            end
        end



        context "Se o usuario não existe..." do
            let(:user_id) {1000}
            it "Retornar 404" do
                expect(response).to have_http_status(404)
            end
        end
    
    end

    describe "POST /users" do
        before do
            headers = { 'Accept' => 'application/vnd.taskmanager.v1'}
            post '/users', params: { user: user_params }, headers: headers
        end

        context 'Quando os parâmetros da requisição forem válidos...' do
            # attributes_for é um método do FactoryGirl
            let(:user_params) { attributes_for(:user)}

            it 'Retornar 201' do
                expect(response).to have_http_status(201)
            end

            it 'Retornar um JSON com os dados do usuário criado' do
                # symbolize_names para conseguir usar simbolos nessa variavel
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:email]).to eq(user_params[:email])
            end
        end

        context 'Quando os parâmetros da requisição forem inválidos...' do
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

    describe "PUT /users/:id" do
        before do
            headers = { 'Accept' => 'application/vnd-taskmanager_v1'}
            put "/users/#{user_id}", params: {user: user_params}, headers: headers
        end
        
        context 'Quando os dados para alterar forem Válidos...' do
            let(:user_params) { { email: 'emaildeteste@testes.com' } }

            it 'Retornar 200' do
                expect(response).to have_http_status(200)    
            end

            it 'Retornar Usuário alterado' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:email]).to eq(user_params[:email])
            end
        end

        context 'Quando os dados para alterar forem Inválidos...' do
            let(:user_params) { { email: 'lucas@@@@' } }
            it 'Retonar 422' do
                expect(response).to have_http_status(422)
            end

            it 'Retonar o erro' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response).to have_key(:errors)
            end
        end
    end

    describe "DELETE /users/:id" do
        before do
            headers = { 'Accept' => 'application/vnd-taskmanager_v1'}
            delete "/users/#{user_id}", params: {}, headers: headers
        end

        it 'Retorna um 204' do
            expect(response).to have_http_status(204)
        end

        it 'Retorna nulo' do
            expect(User.find_by(id: user_id)).to be_nil
        end

    end

end