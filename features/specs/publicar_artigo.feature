#language: pt
@post
Funcionalidade: Publicar artigo

    Sendo o modulo administrativo do blog
    Posso solicitar requisicoes POST para o servico Posts
    Para publicar novos arigos no blog

    @smoke
    Cenário: Publicar novo arigo no blog
        Dado que ou usuário informou o titulo e descricao do artigo
        Quando o modulo de cadastro envia um POST para o serviço Posts
        Então o código de resposta deve ser "200"
            E o Json response deve ter os dados no novo artigo
