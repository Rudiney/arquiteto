# encoding: UTF-8

require 'test_helper'

class IndicadorProjetosTest < ActiveSupport::TestCase

	setup do
		@ip = FactoryGirl.build(:indicador_projeto)
	end

	test "00 - #valor_convertido para número " do
		@ip.indicador = FactoryGirl.build(:indicador, tipo: 'numero')
		@ip.valor = '12.34'
		
		assert_equal(12.34, @ip.valor_convertido)
	end
	
	test "00 - #valor_convertido para duração " do
		@ip.indicador = FactoryGirl.build(:indicador, tipo: 'duracao')
		@ip.valor = '12.34'
		
		assert_equal(12.34, @ip.valor_convertido)
	end
	
	test "00 - #valor_convertido para data" do
		@ip.indicador = FactoryGirl.build(:indicador, tipo: 'data')
		@ip.valor = '31/12/2014'
		
		assert_equal(Date.new(2014,12,31), @ip.valor_convertido)
	end
end