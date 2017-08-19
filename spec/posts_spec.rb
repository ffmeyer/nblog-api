describe 'nblog Api' do
  before(:context) do
    Post.destroy_all
  end

  describe 'POST /posts' do
    describe 'status 200' do
      it 'creates a new post' do
        request = {
          title: 'Novo Artigo',
          image: Faker::LoremPixel.image,
          body: Faker::Lorem.paragraph
        }
        post 'api/posts', request.to_json
        expect_status(200)
      end
    end
  end

  describe 'GET /posts' do
    describe 'STATUS 200' do
      it 'returns a list of posts' do
        get '/api/posts'
        expect_status(201)
        expect_json_types('*', title: :string, body: :string)
      end
    end

    describe 'STATUS 404' do
      it 'message error when post not exist' do
        get '/api/posts/' + Faker::Lorem.characters(25)
        expect_status(404)
        expect(json_body).to eq(message: 'Post Not Found')
      end
    end
  end

  describe 'PUT /posts/:id' do
    describe 'STATUS 200' do
      before do
        request = {
          title: 'Novo Artigo 2',
          image: Faker::LoremPixel.image,
          body: Faker::Lorem.paragraph
        }
        post 'api/posts', request.to_json
        @post = Post.where(title: request[:title]).first
      end
      it 'UPDATE a post' do
        request = {
          title: 'Novo artigo 2 atualizado',
          image: Faker::LoremPixel.image,
          body: Faker::Lorem.paragraph
        }
        put 'api/posts/' + @post[:_id].to_s, request.to_json
        expect_status(200)
      end
    end
  end
    describe 'DELETE /posts/:id' do
      describe 'STATUS 200' do
        before do
          request = {
            title: 'Artigo que será removido',
            image: Faker::LoremPixel.image,
            body: Faker::Lorem.paragraph
          }
          post 'api/posts', request.to_json
          @post = Post.where(title: request[:title]).first
        end
        it 'DELETE a post' do          
          delete 'api/posts/' + @post[:_id].to_s
          expect_status(200)
        end
        it 'Message error when post not exist' do
          delete 'api/posts/' + Faker::Lorem.characters(25)
          expect_status(404)
          expect(json_body).to eq(message: 'Post Not Found')
        end
      end        
  end
end
