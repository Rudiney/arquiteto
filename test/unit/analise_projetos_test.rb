# encoding: UTF-8

require 'test_helper'

class AnaliseProjetosTest < ActiveSupport::TestCase

	setup do
		@analise = AnaliseProjetos.new
	end

	test "00 - sem nenhuma pesquisa traz todos os projetos" do
		FactoryGirl.create_list(:projeto, 3)
		assert_equal(3, @analise.projetos.size)
	end
		
	test "01 - projetos sem valores, nao traz" do
		FactoryGirl.create(:projeto)
		i = FactoryGirl.create(:indicador, tipo: 'numero')
		FactoryGirl.create(:pesquisa, indicador: i, valor: '10', operador: 1)
		assert_equal(0, @analise.projetos.size)
	end
	
	test "02 - indicador de número, pesquisa como igual" do
		i = FactoryGirl.create(:indicador, tipo: 'numero')
		p = FactoryGirl.create(:projeto)
		FactoryGirl.create(:indicador_projeto, projeto: p, indicador: i, valor: '10')
		
		pesquisa = FactoryGirl.create(:pesquisa, indicador: i, valor: '10', operador: 1)
		
		assert_equal(1, @analise.projetos.size, 'não encontrou o projeto')
		assert(@analise.projetos.include?(p), 'nao encontrou o nosso projeto')
		
		pesquisa.update_attributes!(valor: '11')
		
		assert_equal(0, @analise.projetos.size, 'não era pra encontrar nenhum projeto')
	end
	
	test "02 - indicador de número, pesquisa como maior" do
		i = FactoryGirl.create(:indicador, tipo: 'numero')
		p = FactoryGirl.create(:projeto)
		FactoryGirl.create(:indicador_projeto, projeto: p, indicador: i, valor: '10')
		
		pesquisa = FactoryGirl.create(:pesquisa, indicador: i, valor: '9', operador: 2)
		
		assert_equal(1, @analise.projetos.size, 'não encontrou o projeto')
		assert(@analise.projetos.include?(p), 'nao encontrou o nosso projeto')
		
		pesquisa.update_attributes!(valor: '11')
		
		assert_equal(0, @analise.projetos.size, 'não era pra encontrar nenhum projeto')
	end
	
	test "02 - indicador de número, pesquisa como menos" do
		i = FactoryGirl.create(:indicador, tipo: 'numero')
		p = FactoryGirl.create(:projeto)
		FactoryGirl.create(:indicador_projeto, projeto: p, indicador: i, valor: '10')
		
		pesquisa = FactoryGirl.create(:pesquisa, indicador: i, valor: '11', operador: 3)
		
		assert_equal(1, @analise.projetos.size, 'não encontrou o projeto')
		assert(@analise.projetos.include?(p), 'nao encontrou o nosso projeto')
		
		pesquisa.update_attributes!(valor: '9')
		
		assert_equal(0, @analise.projetos.size, 'não era pra encontrar nenhum projeto')
	end
	
	test "03 - o projeto tem que passar em todas as pesquisas" do
		p = FactoryGirl.create(:projeto)
		
		i1 = FactoryGirl.create(:indicador, tipo: 'numero')
		FactoryGirl.create(:indicador_projeto, projeto: p, indicador: i1, valor: '10')
		
		i2 = FactoryGirl.create(:indicador, tipo: 'duracao')
		FactoryGirl.create(:indicador_projeto, projeto: p, indicador: i2, valor: '20')
		
		
		p1 = FactoryGirl.create(:pesquisa, indicador: i1, valor: '10', operador: 1)
		p2 = FactoryGirl.create(:pesquisa, indicador: i2, valor: '20', operador: 1)
		
		assert_equal(1, @analise.projetos.size, 'não encontrou o projeto')
		assert(@analise.projetos.include?(p), 'nao encontrou o nosso projeto')
		
		p2.update_attributes!(valor: '21')
		
		assert_equal(0, @analise.projetos.size, 'não era pra encontrar nenhum projeto')
	end
end


# navegar em cada projeto
## navegar em cada pesquisa,
### se o projeto nao satisfacer a pesquisa, ele cai fora