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
		
		FactoryGirl.create(:indicador_projeto, projeto: @objeto, indicador: indicador, valor: '1')
		
		get(:edit, id: @objeto)
		
		assert_equal(3, assigns(:projeto).indicador_projetos.size)
		
		assigns(:projeto).indicador_projetos.each do |ip|
			if ip.indicador == indicador
				assert_equal('1', ip.valor)
			else
				assert_nil(ip.valor)
			end
		end
	end
	
	test "12 - deixa salvar os indicador_projetos" do
		
		indicadores = FactoryGirl.create_list(:indicador, 2)
		params      = create_params
		
		indicadores.each do |indicador|
			params[:projeto][:indicador_projetos_attributes] ||= {}
			params[:projeto][:indicador_projetos_attributes][indicador.id.to_s] = {
				indicador_id: indicador, valor: indicador.id
			}
		end
		
		assert_difference("Projeto.count", +1) do
		  post(:create, params)
		end
		
		assert_equal(2, assigns(:projeto).indicador_projetos.count)
		
	end
end
