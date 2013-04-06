# encoding: UTF-8

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
	
	test "11 - no edit, carrega os indicadores que o projeto ainda não tenha" do
		indicadores = FactoryGirl.create_list(:indicador, 3)
		indicador = indicadores.first
		FactoryGirl.create(:indicador_projeto, projeto: @objeto, indicador: indicador)
		
		get(:edit, id: @objeto)
		
		assert_equal(3, assigns(:projeto).indicador_projetos.size)
	end
end
