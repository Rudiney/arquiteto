# encoding: UTF-8

require 'test_helper'

class BacklogControllerTest < ActionController::TestCase

	setup do
		sign_in(users(:rudi))
		escolhe_produto(@p = produtos(:dois))
	end
	
	test "com um produto escolhido deve entrar no pb" do
		get('index')
		assert_response :success
	end
	
	test "sem um produto escolhido deve direcionar para a escolha de um produto" do
		@request.session[:produto_id] = nil
		get('index')
		assert_redirected_to('/escolha_um_produto')
	end
	
	test "deve listar somente as histórias do produto escolhido" do
		get('index')
		assert_not_nil(assigns(:historias))
		assigns(:historias).each do |h|
			assert_equal(h.produto, @p)
		end
	end
	
	test "deve ter pelo menos 1 link para inserir 1 história" do
		get('index')
		assert_select('a[href="/historias/new"]')
	end
	
	test "filtros do PB pelo ID" do
		filtros = {:filtros => {id: 21}}
		
		get('index',filtros)
		
		assert_equal(1, assigns(:historias).size)
		assert_equal(21, assigns(:historias).first.id)
		
	end
	
	test "filtro do PB pelo nome" do
		
		filtros = {:filtros => {nome: 'oito'}} #deve trazer a oito e a sexoito
		
		get('index',filtros)
		
		assert_equal(2, assigns(:historias).size)
		
		ids_historias_encontradas = assigns(:historias).collect{|h| h.id }
		
		[28,218].each do |id|
			assert(ids_historias_encontradas.include?(id))
		end
	end
	
	test "filtro do PB por 1 situação" do
		historias_na_situacao_incompleta = Historia.do_produto(@p).na_situacao(:incompleta)
		
		filtros = {:filtros => {situacao: {10 => true}}}
		
		get('index',filtros)
		
		assert_equal(historias_na_situacao_incompleta.count, assigns(:historias).size)
		
		historias_na_situacao_incompleta.each do |h|
			assert(assigns(:historias).include?(h))
		end
	end

	test "filtro do PB por várias situação" do
		historias_na_situacao_incompleta = Historia.do_produto(@p).na_situacao(:incompleta,:aguardando)
		
		filtros = {:filtros => {situacao: {10 => true,20 => true}}}
		
		get('index',filtros)
		
		assert_equal(historias_na_situacao_incompleta.count, assigns(:historias).size)
		
		historias_na_situacao_incompleta.each do |h|
			assert(assigns(:historias).include?(h))
		end
	end	
end