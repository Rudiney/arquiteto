# encoding: UTF-8

require 'test_helper'

class PesquisaTest < ActiveSupport::TestCase

	setup do
		@pesquisa = FactoryGirl.build(:pesquisa)
	end

	test "00 - #valor_convertido para número " do
		@pesquisa.indicador = FactoryGirl.build(:indicador, tipo: 'numero')
		@pesquisa.valor = '12.34'
		
		assert_equal(12.34, @pesquisa.valor_convertido)
	end
	
	test "00 - #valor_convertido para duração " do
		@pesquisa.indicador = FactoryGirl.build(:indicador, tipo: 'duracao')
		@pesquisa.valor = '12.34'
		
		assert_equal(12.34, @pesquisa.valor_convertido)
	end
	
	test "00 - #valor_convertido para data" do
		@pesquisa.indicador = FactoryGirl.build(:indicador, tipo: 'data')
		@pesquisa.valor = '31/12/2014'
		
		assert_equal(Date.new(2014,12,31), @pesquisa.valor_convertido)
	end
end