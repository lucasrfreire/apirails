module RequestSpecHelper
    def json_body
        # symbolize_names para conseguir usar simbolos nessa variavel
        @json_body ||= JSON.parse(response.body, symbolize_names: true)
    end
end