# encoding: UTF-8

require 'test_helper'

class HistoriaRepriorizacaoTest < ActiveSupport::TestCase
	
	setup do
		
		@p = produtos(:um)
		
		@h1 = historias(:um_produto_um)
		@h2 = historias(:dois_produto_um)
		@h3 = historias('três_produto_um')
		@h4 = historias(:quatro_produto_um)
		@h5 = historias(:cinco_produto_um)
		
	end
	
	
	test "alterando várias histórias" do

		#atualizo a primeira história
		@h1.update_attributes(prioridade: 2)
		
		@h2.reload
		assert_equal(3, @h2.prioridade, 'deveria ter alterado a prioridade da @história 2')
		
		@h3.reload
		assert_equal(4, @h3.prioridade, 'deveria ter alterado a prioridade da @história 3')
		
		@h4.reload
		assert_equal(5, @h4.prioridade, 'deveria ter alterado a prioridade da @história 4')
		
		@h5.reload
		assert_equal(6, @h5.prioridade, 'deveria ter alterado a prioridade da @história 5')
		
	end

	test "não altera intervalos e nem as para tráz" do
		
		@h4.update_attributes(prioridade: 5)
		
		assert_equal(6, @h5.reload.prioridade, 'não arrumou a prioridade da historia 5')
		
		@h2.update_attributes(prioridade: 3)
		
		assert_equal(4, @h3.reload.prioridade, 'historia 3')
		assert_equal(1, @h1.reload.prioridade, 'historia 1')
		
	end
end