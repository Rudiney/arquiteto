require 'test_helper'

class ProjetosControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		sign_in(current_user)
		escolhe_produto(produtos(:um))
		@objeto = FactoryGirl.create(:projeto)
	end
	
	test "10 - no new deve carregar todos os indicadores" do
		indicadores = FactoryGirl.create_list(:indicador, 3)
		
		get(:new)
		
		assert_equal(3, assigns(:projeto).indicador_projetos.size)
	end
end
