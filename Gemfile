source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # o rspec é um substituto do framework de teste que já vem por padrão no rails, ela é mais completa e mais simples de usar.
  # rodar após instalar para gerar os arquivos necessarios: rails generate rspec:install
  gem 'rspec-rails', '~> 3.5'
end

# gem especificas para testes
group :test do
  # databse_cleaner, vai ajudar a garantir e fazer a limpeza do banco de dados
  gem 'database_cleaner'
  # shoulda-matchers vai dar mais possibilidades para testar o código, pois adicionar muitos metódos novos
  gem 'shoulda-matchers', '~> 3.1'
  # factory_girl_rails, esse substitui uma funcionalidade no rails que serve para gerar dados pré configurados para testes
  gem 'factory_girl_rails'
  # faker é pra ser usada com a factory_girl_rails, server para gerar dados aleatórios como nome, e-mail, enderço, etc...
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise'