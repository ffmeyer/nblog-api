#language: pt
@put
Funcionalidade: Atualizar artigo

    Sendo o modulo administrativo do blog
    Posso solicitar requisicoes PUT para o servico Posts
    Para atualizar um determinado artigo desejado no blog

    @smoke
    Cenário: Atualizar artigo do blog
        Dado que o usuario selecionou um artigo no blog
        Quando o modulo admin envia um PUT para o serviço Posts
        Então o código de resposta deve ser "200"
            E o Json Response deve conter os dados atualizados do artigo


    Cenário: Artigo não existe
        Dado que o codigo do artigo é invalido ou inexistente
        Quando o modulo admin envia um PUT para o serviço Posts
        Então o código de resposta deve ser "404"