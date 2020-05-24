Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Forma de organizar as rotas em "categorias" criar uma pasta com nome da namespace la em controllers
  # Primeiro parametro cria o path /api
  # Segundo parametro diz que todo mundo aqui dentro vai trabalhar no formato json, para nao ter que especificar em todos
  # Terceiro parametro diz que para acessar essa rota o subdominio tem que ser api, exemplo: api.site.com/api/teste
  # Quarto paramentro e para nao ficar api repetido, agora a url fica assim: api.site.com/teste
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do

  end
end
