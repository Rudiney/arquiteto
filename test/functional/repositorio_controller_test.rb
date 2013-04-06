require 'test_helper'

class RepositorioControllerTest < ActionController::TestCase
	
	setup do
		sign_in(users(:rudi))
		escolhe_produto(@p = produtos(:um))
		@r = repositorios(:produto_um)
	end
	
	test "nao pode acessar sem um produto escolhido" do
		deve_ter_um_produto_escolhido_para_acessar_as_acoes([:edit,:update])
	end
	
	test "se o produto escolhido ja tem um repositorio, deve trazer os dados deste repositorio" do
		get(:edit)
		assert_equal(@r, assigns(:repositorio))
	end
	
	test "se o pojeto nao tem repositorio, criar-lo" do
		
		Repositorio.destroy_all
		
		assert_equal(0, Repositorio.count)
		
		assert_difference("Repositorio.count",+1) do
			post(:update,{:repositorio => {
				endereco: 'endereco_de_teste',
				ultima_revisao_importada: '5'
			}})
		end
		
		assert_redirected_to(action: :edit)

		assert_not_nil(assigns(:repositorio))
		assert_equal(@p, assigns(:repositorio).produto)
		assigns(:produto_escolhido).reload
		assert_not_nil(@p.repositorio)
		assert_equal(assigns(:repositorio), assigns(:produto_escolhido).repositorio)
	end
	
	test "altera o repositorio com sucesso" do
		post(:update,{:repositorio => {
			endereco: 'novo_endereco',
			ultima_revisao_importada: '6'
		}})
		
		assert_redirected_to(action: :edit)
		assert_equal('novo_endereco', assigns(:repositorio).endereco)
		assert_equal(6, assigns(:repositorio).ultima_revisao_importada)
		
	end

	test "importacao arquivos" do

	end
end