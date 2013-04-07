# encoding: UTF-8

require 'test_helper'

class IndicadorsControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		sign_in(current_user)
		escolhe_produto(produtos(:um))
		@objeto = FactoryGirl.create(:indicador)
	end
	
	test "10 - no new deve carregar todos os projetos" do
		projetos = FactoryGirl.create_list(:projeto, 3)
		
		get(:new)
		
		assert_equal(3, assigns(:indicador).indicador_projetos.size)
	end
	
	test "11 - no edit, carrega os projetos que o indicador ainda não tenha" do
		projetos = FactoryGirl.create_list(:projeto, 3)
		projeto = projetos.first
		
		FactoryGirl.create(:indicador_projeto, indicador: @objeto, projeto: projeto, valor: '1')
		
		get(:edit, id: @objeto)
		
		assert_equal(3, assigns(:indicador).indicador_projetos.size)
		
		assigns(:indicador).indicador_projetos.each do |ip|
			if ip.projeto == projeto
				assert_equal('1', ip.valor)
			else
				assert_nil(ip.valor)
			end
		end
	end
	
	test "12 - deixa salvar os indicador_projetos pelo indicador" do
		
		projetos = FactoryGirl.create_list(:projeto, 2)
		params      = create_params
		
		projetos.each do |projeto|
			params[:indicador][:indicador_projetos_attributes] ||= {}
			params[:indicador][:indicador_projetos_attributes][projeto.id.to_s] = {
				projeto_id: projeto, valor: projeto.id
			}
		end
		
		assert_difference("Indicador.count", +1) do
		  post(:create, params)
		end
		
		assert_equal(2, assigns(:indicador).indicador_projetos.count)
		
	end
end
