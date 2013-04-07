# encoding: UTF-8

require 'test_helper'

class PesquisaTest < ActiveSupport::TestCase

	setup do
		@projeto = FactoryGirl.create(:projeto)
	end
	
	test "01 - satisfaz a pesquisa com indicador de número filtrando igual?" do
		i = FactoryGirl.create(:indicador, tipo: 'numero')
		@projeto.indicador_projetos.create(indicador: i, valor: '10')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '10', operador: 1)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '11'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
		
		pesquisa.valor = '9'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "02 - satisfaz a pesquisa com indicador de número filtrando maior" do
		i = FactoryGirl.create(:indicador, tipo: 'numero')
		@projeto.indicador_projetos.create(indicador: i, valor: '10')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '9', operador: 2)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '11'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "03 - satisfaz a pesquisa com indicador de número filtrando menos" do
		i = FactoryGirl.create(:indicador, tipo: 'numero')
		@projeto.indicador_projetos.create(indicador: i, valor: '10')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '11', operador: 3)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '9'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "04 - satisfaz a pesquisa com indicador de duração filtrando igual?" do
		i = FactoryGirl.create(:indicador, tipo: 'duracao')
		@projeto.indicador_projetos.create(indicador: i, valor: '10')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '10', operador: 1)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '11'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
		
		pesquisa.valor = '9'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "05 - satisfaz a pesquisa com indicador de duração filtrando maior" do
		i = FactoryGirl.create(:indicador, tipo: 'duracao')
		@projeto.indicador_projetos.create(indicador: i, valor: '10')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '9', operador: 2)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '11'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "06 - satisfaz a pesquisa com indicador de duracao filtrando menos" do
		i = FactoryGirl.create(:indicador, tipo: 'duracao')
		@projeto.indicador_projetos.create(indicador: i, valor: '10')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '11', operador: 3)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '9'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "07 - satisfaz a pesquisa com indicador de data filtrando igual?" do
		i = FactoryGirl.create(:indicador, tipo: 'data')
		@projeto.indicador_projetos.create(indicador: i, valor: '10/12/2010')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '10/12/2010', operador: 1)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '05/01/2011'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
		
		pesquisa.valor = '02/12/2010'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "05 - satisfaz a pesquisa com indicador de data filtrando maior" do
		i = FactoryGirl.create(:indicador, tipo: 'data')
		@projeto.indicador_projetos.create(indicador: i, valor: '10/12/2010')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '05/12/2010', operador: 2)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '11/12/2010'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end
	
	test "06 - satisfaz a pesquisa com indicador de data filtrando menor" do
		i = FactoryGirl.create(:indicador, tipo: 'data')
		@projeto.indicador_projetos.create(indicador: i, valor: '10/12/2010')
		pesquisa = FactoryGirl.build(:pesquisa, indicador: i, valor: '11/12/2010', operador: 3)
		
		assert(@projeto.satisfaz_pesquisa?(pesquisa), "deveria satisfazer a pesquisa, está igual")
		
		pesquisa.valor = '09/12/2010'
		assert(!@projeto.satisfaz_pesquisa?(pesquisa), "não deveria satisfazer a pesquisa")
	end

end