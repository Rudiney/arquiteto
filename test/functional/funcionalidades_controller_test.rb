# encoding: UTF-8

require 'test_helper'

class FuncionalidadesControllerTest < ActionController::TestCase
	
	setup do
		sign_in(users(:rudi))
		escolhe_produto(@p = produtos(:um))
		
		@f = funcionalidades(:um_produto_um)
	end
	
	test "nenhuma acao pode ser acessada sem um produto escolhido" do
		deve_ter_um_produto_escolhido_para_acessar_as_acoes([:index,:new,:create,:edit,:update,:destroy])
	end
	
	test "acos que devem ser acessada com umas sessao" do
		[:new, :edit].each do |acao|
			get(acao,{id: @f.id})
			assert_response(:success, "Deveria acessar a ação #{acao} já que tenho um produto escolhido")
		end
	end
	
	test "deve criar uma funcionalidade" do	
		assert_difference('Funcionalidade.count',1) do
			post(:create,{funcionalidade: @f.attributes})
		end
		assert_not_nil(assigns(:funcionalidade))
		assert_redirected_to(funcionalidade_path(assigns(:funcionalidade)))
	end
	
	test "deve atualizar uma funcionalidae" do
		post(:update,{id: @f.id, funcionalidade: @f.attributes})
		assert_redirected_to(funcionalidade_path(assigns(:funcionalidade)))
		assert_not_nil(assigns(:funcionalidade))
	end
	
	test "deve deletar uma funcionalidade" do
		assert_difference('Funcionalidade.count', -1) do
			delete(:destroy,{id: @f.to_param})
		end
		assert_redirected_to(funcionalidades_path)
	end

	test "o index deve listar so as funcionalidades do produto atual" do
		get('index')
		funcionalidades_do_produto = Funcionalidade.do_produto(@p)
		assert_equal(funcionalidades_do_produto.count, assigns(:funcionalidades).size)
		assert_equal(funcionalidades_do_produto, assigns(:funcionalidades))
	end
	
	test "no index, deve ter um link para os artigos na wiki de todas as funcionalidaes" do
		get('index')
		assert_response(:success)
		Funcionalidade.all.each do |f|
			assert_select('a[href=?]',f.url_artigo_wiki)
		end
	end
	
	test "deve atribuir o produto escolhido na funcionalidade" do
		@f.produto_id = nil
		post(:create,{funcionalidade: @f.attributes})
		assert_not_nil(assigns(:funcionalidade))
		assert_equal(@p, assigns(:funcionalidade).produto)
	end
	
	test "o link para a wiki no show deve estar correto" do
		get(:show,{id: @f.id})
		assert_select('a[href=?]',@f.url_artigo_wiki)
	end
	
	test "deve listar todas as suas historias" do
		get(:show,{id: @f.id})
		
		@f.historias.each do |h|
			assert_select("a[href=\"/historias/#{h.id}\"]",1)
		end
	end
	
	test "deve listar todos seus arquivos fonte" do
		
		get(:show,{id: @f.id})
		
		assert_select("div[id=\"arquivos_fonte\"]") do |tabela|
			@f.arquivos_fonte.each do |af|
				assert_select('td',af.caminho_completo)
			end			
		end
	end
	
	test "deve listar todos suas relações técnicas" do
		
		get(:show,{id: @f.id})
		
		assert_select("div[id=\"relacionamentos_tecnicos\"]") do |tabela|
			@f.funcionalidades_relacionadas_tecnicamente.each do |f|
				assert_select("a[href=\"/funcionalidades/#{f.id}\"]",1)
			end			
		end
	end
	
	# bug pego quando tentado colocar em ambiente de produção, quando cria uma nova funcionalidade
	# não abria o show porque a funcionalidade nao tinha arquivos fonte!
	test "nao abre o show de uma funcionalidade sem arquivos fonte" do
		f = Funcionalidade.new(
			nome: 'nova', 
			produto_id: 1
		)
		assert(f.save, "ixi, nem salvou a nova funcionalidade")

		get(:show,{id: f.id})
		assert_response(:success, "acabei de criar uma funcionalidade e o seu show não funciona")		
		
	end
	
end
