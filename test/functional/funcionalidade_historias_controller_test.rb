# encoding: UTF-8

require 'test_helper'

class FuncionalidadeHistoriasControllerTest < ActionController::TestCase
	
	setup do
		sign_in(users(:rudi))
		
		escolhe_produto(@p = produtos(:dois))
		
		@h_um = historias(:um_produto_dois)
		@f_um = funcionalidades(:um_produto_dois)
		@fh_um = funcionalidade_historias(:funcionalidade_um_historia_um_produto_dois)
		
		@h_quatro = historias(:quatro_produto_dois)
		@f_quatro = funcionalidades(:quatro_produto_dois)
		
		@hum_pum = historias(:um_produto_um)
		@fum_pum = funcionalidades(:um_produto_um)
	end
	
	test "nenhuma acao pode ser acessada sem um produto escolhido" do
		deve_ter_um_produto_escolhido_para_acessar_as_acoes([:novo,:deleta])
	end
	
	test "novo relacionamento com sucesso" do
		assert_difference("FuncionalidadeHistoria.count", +1) do
		  post(:novo,{entre: @h_um, e: @f_quatro})
		end
	end
	
	test "deleta com sucesso" do
		assert_difference("FuncionalidadeHistoria.count", -1) do
		  post(:deleta,{id:@fh_um.id, historia:@fh_um.historia.id})
		end
	end
	
	test "nao pode criar de produtos diferentes" do
		assert_difference("FuncionalidadeHistoria.count", 0) do
		  post(:novo,{entre: @h_um, e: @fum_pum})
		end
		
		assert_difference("FuncionalidadeHistoria.count", 0) do
		  post(:novo,{entre: @hum_pum, e: @f_um})
		end
	end

end