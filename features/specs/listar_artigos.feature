#language: pt

@get
Funcionalidade: Listar artigos

    Sendo o módulo admin do bloq
    Posso solicitar requisicoes GET para o servico posts
    para listar artigos o blog
@smoke
    Cenário: Listar artigos
        Quando o módulo admin enviar um GET para o serviço POSTS            
        Então o código de resposta deve ser "200"
            E o Json response deve conter uma lista de artigos           
    @erro
    Cenário: Listar unico artigo 
        Dado que o usuario selecionou um artigo para visualização
        Quando o módulo	admin enviar um GET desse argio para o serviço Posts`
        Então o código de resposta deve ser "200"

        