#language: pt
@delete 
    Funcionalidade: Remover artigo
        Sendo o modulo admin do blog 
        Posso solicitar requisicoes DELETE para o serviço Posts
        Para remover um determinado artigo no blog
    @smoke
    Cenário: Remover um artigo do blog
        Dado que o usuario selecionou um artigo no blog
        Quando o modulo admin envia um DELETE para o serviço Posts
        Então o código de resposta deve ser "200"
            E o artigo não deve ser exibido ao solicitar uma busca