# encoding: UTF-8

require 'test_helper'

class IndicadorsControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		sign_in(current_user)
		escolhe_produto(produtos(:um))
		@objeto = FactoryGirl.create(:indicador)
	end
	
	test "10 - deixa salvar os indicador_projetos pelo indicador" do
		
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
