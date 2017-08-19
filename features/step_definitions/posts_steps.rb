  # encoding: utf-8

  Dado(/^que ou usuário informou o titulo e descricao do artigo$/) do
    @request = {
      title: 'Executando Testes no Capybara com Chrome Headless',
      image: 'http://qaninja.com.br/static/nblog/headless.png',
      body: "#{$env.upcase} - #{Faker::Lorem.paragraph(2)}"
    }
  end

  Quando(/^o modulo de cadastro envia um POST para o serviço Posts$/) do
    post '/api/posts', @request.to_json
  end

  Então(/^o código de resposta deve ser "([^"]*)"$/) do |http_code|
    expect_status(http_code)
  end

  Então(/^o Json response deve ter os dados no novo artigo$/) do
    get '/api/posts/' + headers[:_id]
    expect(json_body).to include(
      title: @request[:title],
      body: @request[:body]
    )
  end

  # #GET
  Quando(/^o módulo admin enviar um GET para o serviço POSTS$/) do
    get '/api/posts'
  end

  Então(/^o Json response deve conter uma lista de artigos$/) do
    expect(json_body).not_to be_empty
    expect_json_types('*', title: :string, body: :string)
  end

  # #put

  Dado(/^que o usuario selecionou um artigo no blog$/) do
    steps %(
      Dado que ou usuário informou o titulo e descricao do artigo
        Quando o modulo de cadastro envia um POST para o serviço Posts
    )
    @post_id = headers[:_id]
  end

  Dado(/^que o codigo do artigo é invalido ou inexistente$/) do
    @post_id = Faker::Lorem.characters(25)
  end

  Quando(/^o modulo admin envia um PUT para o serviço Posts$/) do
    @request = {
      title: 'Choco, um jeito doce de instalar coisas no Windows',
      image: 'http://qaninja.com.br/static/nblog/choco.png',
      body: "#{$env.upcase} - #{Faker::Lorem.paragraph(2)}"
    }
    put '/api/posts/' + @post_id.to_s, @request.to_json
  end

  Então(/^o Json Response deve conter os dados atualizados do artigo$/) do
    get '/api/posts/' + @post_id.to_s
    expect(json_body).to include(
      title: @request[:title],
      image: @request[:image],
      body: @request[:body]
    )
  end

  ## DELETE

  Quando(/^o modulo admin envia um DELETE para o serviço Posts$/) do
    delete '/api/posts/' + @post_id.to_s
  end

  Então(/^o artigo não deve ser exibido ao solicitar uma busca$/) do
    get '/api/posts/' + @post_id.to_s
    expect_status(404)
  end


##erros

Dado(/^que o usuario selecionou um artigo para visualização$/) do
  post_id = "0000"
end

Quando(/^o módulo\tadmin enviar um GET desse argio para o serviço Posts`$/) do
  get '/api/posts/' + @post_id.to_s
end