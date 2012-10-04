# encoding: UTF-8

require 'test_helper'

class RelacaoFuncionalidadesControllerTest < ActionController::TestCase
	
	setup do
		@p = produtos(:um)
		
		@fum_pum     = funcionalidades(:um_produto_um)
		@fdois_pum   = funcionalidades(:dois_produto_um)
		
		@fum_pdois   = funcionalidades(:um_produto_dois)
		@fdois_pdois = funcionalidades(:dois_produto_dois)
		
		@r_fum_fcinco_pum   = relacao_funcionalidades(:entre_um_e_cinco_produto_um)
		@r_fum_fcinco_pdois = relacao_funcionalidades(:entre_um_e_cinco_produto_dois)
		
		@sessao = {produto_id: @p.id}
	end
	
	test "as ações não podem ser acessadas sem um produto escolhido" do
		deve_ter_um_produto_escolhido_para_acessar_as_acoes([:novo,:deleta,:mapa_impacto])
	end
	
	test "adicionar com sucesso" do
		assert_difference("RelacaoFuncionalidades.count", +1) do
		  post(:novo,{entre: @fum_pum, e: @fdois_pum, relacao: :forte},@sessao)
		end

		assert_difference("RelacaoFuncionalidades.count", +1) do
		  post(:novo,{entre: @fum_pdois, e: @fdois_pdois, relacao: :fraca},@sessao)
		end

	end
	
	test "delete com sucesso" do
		
		assert_difference("RelacaoFuncionalidades.count", -1) do
		  post(:deleta,{id: @r_fum_fcinco_pum, funcionalidade: @fum_pum.id},@sessao)
		end

		assert_difference("RelacaoFuncionalidades.count", -1) do
		  post(:deleta,{id: @r_fum_fcinco_pdois, funcionalidade: @fum_pum.id},@sessao)
		end
		
	end
	
	test "Não pode adicionar relacioamento entre funcionalidaes de produtos diferentes" do
		assert_difference("RelacaoFuncionalidades.count", 0) do
		  post(:novo,{entre: @fum_pum, e: @fdois_pdois, relacao: :forte},@sessao)
		end
	end

	test "mapa de impacto" do
		get(:mapa_impacto,nil,@sessao)
		assert_response(:success)
		
		
		funcionalidades_do_produto = @p.funcionalidades
		
		funcionalidades_do_produto.each do |f|
			#deve ter 2 link para cada funcionalidade (coluna/linha)
			assert_select("a[href=\"/funcionalidades/#{f.id}\"]",2)
			
			f.relacionamentos_com.each do |r|
				id_td = "relacao_entre_#{r.funcionalidade_um.id}_e_#{r.funcionalidade_dois.id}"				
				assert_select("td[id=\"#{id_td}\"]",1)
				assert_select("td[id=\"#{id_td}\"] div[class=\"relacao_#{r.relacao}\"]",1)
			end
			
			f.relacionamentos_de.each do |r|
				id_td = "relacao_entre_#{r.funcionalidade_um.id}_e_#{r.funcionalidade_dois.id}"				
				assert_select("td[id=\"#{id_td}\"]",1)
				assert_select("td[id=\"#{id_td}\"] div[class=\"relacao_#{r.relacao}\"]",1)
			end
		end
	end

end
