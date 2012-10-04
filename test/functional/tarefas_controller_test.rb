# encoding: UTF-8

require 'test_helper'

class TarefasControllerTest < ActionController::TestCase
	
	setup do
		@p = produtos(:dois)	
		@sessao = {produto_id: @p.id}

		@h = historias(:um_produto_dois)
		@t = tarefas(:documentar_historia_um_produto_dois)

	end

	test "deve ter uma sessao" do
		deve_ter_um_produto_escolhido_para_acessar_as_acoes([:nova,:deleta])
	end

	test "nova tarefa com sucesso" do
		assert_difference("Tarefa.count",+1) do
			post(:nova,{historia_id: @h, tarefa:{
				descricao:'Tarefa de teste',
				tempo_estimado: '1:50',
				tempo_real: '5:30'
			}},@sessao)
		end
		
		assert_not_nil(assigns(:historia))
		assert_not_nil(assigns(:tarefa))
		
		assert_equal('Tarefa de teste', assigns(:tarefa).descricao)
	end
	
	test "editar uma tarefa" do
		post(:atualiza,{id: @t.id, tarefa: @t.attributes},@sessao)
	end

	test "deleta com sucesso" do
		assert_difference("Tarefa.count",-1) do
			post(:deleta,{id: @t.id},@sessao)
		end
		assert_not_nil(assigns(:historia))
	end
end
