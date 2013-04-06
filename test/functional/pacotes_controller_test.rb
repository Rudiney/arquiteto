# encoding: UTF-8

require 'test_helper'

class PacotesControllerTest < ActionController::TestCase
	setup do
		sign_in(users(:rudi))
		escolhe_produto(@p = produtos(:dois))
		@pacote = pacotes(:um_produto_dois)
	end

	test "com um produto escolhido deve entrar" do
		get('index')
		assert_response :success
	end

	test "sem um produto escolhido deve direcionar para a escolha de um produto" do
		@request.session[:produto_id] = nil
		get('index')
		assert_redirected_to('/escolha_um_produto')
	end

	test "deve criar um pacote" do	
		assert_difference('Pacote.count',1) do
			post(:create,{pacote: @pacote.attributes})
		end
		assert_not_nil(assigns(:pacote))
		assert_redirected_to(assigns(:pacote))
	end
	
	test "deve atualizar um pacote" do
		post(:update,{id: @pacote.id, pacote: @pacote.attributes})
		assert_redirected_to(pacote_path(assigns(:pacote)))
		assert_not_nil(assigns(:pacote))
	end
	
	test "deve deletar um pacote" do
		assert_difference('Pacote.count', -1) do
			delete(:destroy,{id: @pacote.to_param})
		end
		assert_redirected_to(pacotes_path)
	end

	test "deve listar somente os pacotes do produto escolhido" do
		get('index')
		assert_not_nil(assigns(:pacotes))
		assigns(:pacotes).each do |h|
			assert_equal(h.produto, @p)
		end
	end
	
	test "deve ter pelo menos 1 link para inserir 1 história" do
		get('index')
		assert_select('a[href="/pacotes/new"]')
	end
end