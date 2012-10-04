# encoding: UTF-8

require 'test_helper'

class ListaHistoriasControllerTest < ActionController::TestCase
	
	setup do
		@p = produtos(:dois)
		
		@sessao = {produto_id: @p.id}
	end

	test "com um produto escolhido deve entrar na lista com todas as histórias" do
		get('index',nil,@sessao)
		assert_response(:success)
		assert_equal(@p.historias.size, assigns(:historias).size)
	end
	
	test "deve listar somente as histórias do produto escolhido" do
		get('index',nil,@sessao)
		assert_not_nil(assigns(:historias))
		assigns(:historias).each do |h|
			assert_equal(h.produto, @p)
		end
	end
	
	test "sem um produto escolhido deve direcionar para a escolha de um produto" do
		get('index')
		assert_redirected_to('/escolha_um_produto')
	end
	
	test "filtrando por um pacote" do
		pacote = pacotes(:dois_produto_dois)
		
		get('index',{filtros:{pacotes: [pacote.id]}},@sessao)
		assert_response(:success)
		assert_not_nil(assigns(:historias))
		
		assigns(:historias).each do |h|
			assert_equal(pacote, h.pacote, "na história #{h.id}")
		end
	end
	
	test "filtrando por vários pacote" do
		pacote1 = pacotes(:quatro_produto_dois)
		pacote2 = pacotes(:dois_produto_dois)
		
		get('index',{filtros:{pacotes: [pacote1.id, pacote2.id]}},@sessao)
		assert_response(:success)
		assert_not_nil(assigns(:historias))
		
		assert_equal((pacote1.historias.size + pacote2.historias.size), assigns(:historias).size)
	end
	
	test "filtrando por uma situação" do
		historias_na_situacao_incompleta = Historia.do_produto(@p).na_situacao(:incompleta)
		
		filtros = {:filtros => {situacao: {10 => true}}}
		
		get('index',filtros,@sessao)
		
		assert_equal(historias_na_situacao_incompleta.count, assigns(:historias).size)
		
		historias_na_situacao_incompleta.each do |h|
			assert_equal(10, h.situacao)
		end
	end
	
	test "filtro por várias situação" do
		historias_na_situacao_incompleta = Historia.do_produto(@p).na_situacao(:incompleta,:aguardando)
		
		filtros = {:filtros => {situacao: {10 => true,20 => true}}}
		
		get('index',filtros,@sessao)
		
		assert_equal(historias_na_situacao_incompleta.count, assigns(:historias).size)
		
		historias_na_situacao_incompleta.each do |h|
			assert(assigns(:historias).include?(h))
		end
	end
end