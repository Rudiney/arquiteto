# encoding: UTF-8

require 'test_helper'

class EscolhaUmProdutoControllerTest < ActionController::TestCase
	
	test "na escolha de um produto nao pode redirecionar para ela mesma" do
		get('index')
		assert_response(:success)
	end
	
	test "deve escolher um produto com sucesso" do
		produto_escolhido = produtos(:um)
		get('escolhido', :id => produto_escolhido.id)
		assert_equal(produto_escolhido.id, session[:produto_id])
		assert_redirected_to(controller: :backlog)
	end
	
	test "tentar escolher um produto que não existe deve voltar para a lista" do
		get('escolhido', :id => 9999) # 999 não existe
		assert_redirected_to(controller: :escolha_um_produto)
		assert_nil(session[:produto_id])
	end
	
	test "conteudo da escolha de um produto" do
		get('index')
		assert_select('a[href="/produtos/new"]')
		Produto.all.each do |produto|
			assert_select("a[href=/escolha_um_produto/escolhido/#{produto.id}]",1)
		end	
	end
	
	test "direciona para o pb se tentar escolher um produto sem sair dele" do
		produto = produtos(:um)
		get('index',nil,{'produto_id' => produto.id})
		assert_redirected_to(controller: :backlog)
		assert_equal(produto.id, session[:produto_id])
	end

	test "deve sair do produto com sucesso" do
		produto = produtos(:um)
		get('sai_do_produto_atual',nil,{'produto_id' => produto.id})
		assert_redirected_to("/escolha_um_produto")
		assert_nil(session[:produto_id])
	end
	
	test "se só tem um produto no sistema só este deve ser utilizado" do
		produto = deixa_somente_um_produto_no_sistema
		get('index')
		assert_redirected_to(controller: :backlog)
		assert_equal(produto.id, session[:produto_id])
	end
	
	test "se só tem um produto, não deixa sair do produto atual" do
		produto = deixa_somente_um_produto_no_sistema
		get('sai_do_produto_atual',nil,{:produto_id => produto.id})
		assert_redirected_to(controller: :backlog)
		assert_equal(produto.id, session[:produto_id])
	end

	private
	
	def deixa_somente_um_produto_no_sistema
		atts_primeiro_produto = produtos(:um).attributes
		Produto.destroy_all
		
		return  Produto.create(atts_primeiro_produto)

	end
end
