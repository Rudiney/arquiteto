# encoding: UTF-8

require 'test_helper'

class HistoriasControllerTest < ActionController::TestCase
	
	setup do
		sign_in(users(:rudi))
		escolhe_produto(@p = produtos(:um))
		
		@h = historias(:um_produto_um)
	end
	
	test "nenhuma acao pode ser acessada sem um produto escolhido" do
		deve_ter_um_produto_escolhido_para_acessar_as_acoes([:new,:create,:edit,:update,:destroy])
	end
	
	test "acos que devem ser acessada com uma sessao" do
		[:new, :edit].each do |acao|
			get(acao,{id: @h.id})
			assert_response(:success, "Deveria acessar a ação #{acao} já que tenho um produto escolhido")
		end
	end
	
	test "deve criar uma historia" do	
		assert_difference('Historia.count',1) do
			post(:create,{historia: @h.attributes})
		end
		assert_not_nil(assigns(:historia))
		assert_redirected_to(historia_path(assigns(:historia)))
	end
	
	test "deve atualizar uma historia" do
		post(:update,{id: @h.id, historia: @h.attributes})
		assert_redirected_to(historia_path(assigns(:historia)))
		assert_not_nil(assigns(:historia))
	end
	
	test "deve deletar uma historia" do
		assert_difference('Historia.count', -1) do
			delete(:destroy,{id: @h.to_param})
		end
		assert_redirected_to(controller: :backlog)
	end

	test "deve atribuir o produto escolhido na historia" do
		@h.produto_id = nil
		post(:create,{historia: @h.attributes})
		assert_not_nil(assigns(:historia))
		assert_equal(@p, assigns(:historia).produto)
	end	

	test "na visualizacao deve exibir todas as suas funcionalidades" do
		get(:show,{id:@h.id})
		assert_not_nil(assigns(:historia))
		
		assigns(:historia).funcionalidades.each do |f|
			assert_select("a[href=\"/funcionalidades/#{f.id}\"]",1)
		end
	end

	test "na visualizacao deve exibir todas as suas tarefas" do
		get(:show,{id:@h.id})
		assert_not_nil(assigns(:historia))
		
		assert_select("div[id=\"tarefas\"]") do |tabela|
			assigns(:historia).tarefas.each do |f|
				assert_select('td',f.identificador)
				assert_select('td',f.descricao)
				assert_select('td',f.tempo_estimado)
				assert_select('td',f.tempo_real)
			end			
		end
	end

	test "na visualizacao deve exibir todas os seus arquivos fontes" do
		get(:show,{id:@h.id})
		
		assert_not_nil(assigns(:historia))
		
		assert_select("div[id=\"arquivos_fonte\"]") do |tabela|
			assigns(:historia).arquivos_fonte.each do |af|
				assert_select('td',af.caminho_completo)
			end			
		end
	end

end