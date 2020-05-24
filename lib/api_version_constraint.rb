# Essa classe vai fazer a verificaçao da versao da api

class ApiVersionConstraint
    # Ja vai receber a versao na qual ta tentando entrar e se aquela versao e padrao ou nao
    def initialize(options)
        @version = options[:version]
        @default = options[:default]
    end

    # Aqui vai pegar a requisiçao e verificar se aquela versao e a padrao ou se corresponde ao mimetype no Accept do Header da requisicao
    def matches?(req)
        @default || req.headers['Accept'].include?("application/vnd.taskmanager.v#{version}")
    end
end