require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user)}
    let(:user_id) {user.id}
    let(:headers) do
        {
            'Accept' => "application/vnd.taskmanager.v1",
            'Content-Type' => Mime[:json].to_s
        }
    end

    before { host! "api.task-manager.test"}

    describe "GET /users/:id" do
        before do
            get "/users/#{user_id}", params: {}, headers: headers
        end
    
        context "se o usuario existe" do
            it "Retornar o usuário" do
                expect(json_body[:id]).to eq(user_id)
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
            post '/users', params: { user: user_params }.to_json, headers: headers
        end

        context 'Quando os parâmetros da requisição forem válidos...' do
            # attributes_for é um método do FactoryGirl
            let(:user_params) { attributes_for(:user)}

            it 'Retornar 201' do
                expect(response).to have_http_status(201)
            end

            it 'Retornar um JSON com os dados do usuário criado' do
                expect(json_body[:email]).to eq(user_params[:email])
            end
        end

        context 'Quando os parâmetros da requisição forem inválidos...' do
            let(:user_params) { attributes_for(:user, email: 'lucas@@@')}

            it 'Retornar 422' do
                expect(response).to have_http_status(422)
            end

            it 'Retonar um JSON com os erros' do
                expect(json_body).to have_key(:errors)
            end
        end
    end

    describe "PUT /users/:id" do
        before do
            put "/users/#{user_id}", params: {user: user_params}.to_json, headers: headers
        end
        
        context 'Quando os dados para alterar forem Válidos...' do
            let(:user_params) { { email: 'emaildeteste@testes.com' } }

            it 'Retornar 200' do
                expect(response).to have_http_status(200)    
            end

            it 'Retornar Usuário alterado' do
                expect(json_body[:email]).to eq(user_params[:email])
            end
        end

        context 'Quando os dados para alterar forem Inválidos...' do
            let(:user_params) { { email: 'lucas@@@@' } }
            it 'Retonar 422' do
                expect(response).to have_http_status(422)
            end

            it 'Retonar o erro' do
                expect(json_body).to have_key(:errors)
            end
        end
    end

    describe "DELETE /users/:id" do
        before do
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