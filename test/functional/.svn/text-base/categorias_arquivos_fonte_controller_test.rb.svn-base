# encoding: UTF-8

require 'test_helper'

class CategoriasArquivosFonteControllerTest < ActionController::TestCase
	
	setup do
		@p = produtos(:um)
		@caf = categorias_arquivos_fonte(:controladores_produto_um)
		@sessao = {produto_id: @p.id}
	end
	
	test "nenhuma acao pode ser acessada sem um produto escolhido" do
		deve_ter_um_produto_escolhido_para_acessar_as_acoes([:new,:create,:edit,:update,:destroy])
	end
	
	test "acos que devem ser acessada com uma sessao" do
		[:new, :edit].each do |acao|
			get(acao,{id: @caf.id},@sessao)
			assert_response(:success, "Deveria acessar a ação #{acao} já que tenho um produto escolhido")
		end
	end
	
	test "deve criar uma categoria" do	
		assert_difference('CategoriaArquivoFonte.count',1) do
			nova = {nome: 'outro nome', string_expressao_regular: 'outra string'}
			post(:create,{categoria_arquivo_fonte: nova},@sessao)
		end
		
		assert_not_nil(assigns(:categoria_arquivo_fonte))
		assert_redirected_to(categoria_arquivo_fonte_path(assigns(:categoria_arquivo_fonte)))
	end
	
	test "deve atualizar uma categoria" do
		post(:update,{id: @caf.id, categoria_arquivo_fonte: @caf.attributes},@sessao)
		assert_redirected_to(categoria_arquivo_fonte_path(assigns(:categoria_arquivo_fonte)))
		assert_not_nil(assigns(:categoria_arquivo_fonte))
	end
	
	test "deve deletar uma categoria_arquivo_fonte" do
		assert_difference('CategoriaArquivoFonte.count', -1) do
			delete(:destroy,{id: @caf.to_param},@sessao)
		end
		assert_redirected_to(controller: :categorias_arquivos_fonte)
	end
	
	test "deve atribuir o produto escolhido na categorias_arquivos_fonte" do
		@caf.produto_id = nil
		post(:create,{categoria_arquivo_fonte: @caf.attributes},@sessao)
		assert_not_nil(assigns(:categoria_arquivo_fonte))
		assert_equal(@p, assigns(:categoria_arquivo_fonte).produto)
	end	
	
	test "no show deve mostrar todos os seus arquivos fonte" do
		get(:show,{id: @caf.id},@sessao)

		assert_select("div[id=\"arquivos_fonte\"]") do |tabela|
			@caf.arquivos_fonte.each do |af|
				assert_select('td',af.caminho_completo)
			end			
		end
	end
end