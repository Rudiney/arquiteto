# encoding: UTF-8

require 'test_helper'

class FuncionalidadeHistoriaTest < ActiveSupport::TestCase
	
	setup do
		@p = produtos(:um)
		
		@f_um = funcionalidades(:um_produto_um)
		@h_um = historias(:um_produto_um)
		@fh_um = funcionalidade_historias(:funcionalidade_um_historia_um_produto_um)
		
		@f_dois = funcionalidades(:dois_produto_dois)
		@h_doze = historias(:doze_produto_dois)
		@fh_dois = funcionalidade_historias(:funcionalidade_dois_historia_doze_produto_dois)
	end
	
	test "salvar as fixtures com sucesso" do
		FuncionalidadeHistoria.all.each do |fh|
			assert(fh.save)
		end
	end
	
	test "uma história e uma funcionalidade são obrigatórios" do
		@fh_um.historia_id = nil
		assert(!@fh_um.save)
		
		@fh_dois.funcionalidade_id = nil
		assert(!@fh_dois.save)
	end
	
	test "não pode haver 2 relacionamentos iguais" do
		duplicado = FuncionalidadeHistoria.new(@fh_dois.attributes)
		assert(!duplicado.save)
		
		duplicado = FuncionalidadeHistoria.new(@fh_um.attributes)
		assert(!duplicado.save)
	end
	
	test "a funcionalidade deve existir" do
		@fh_um.funcionalidade_id = 888
		assert(!@fh_um.save)
		
		@fh_dois.funcionalidade_id = 999
		assert(!@fh_dois.save)
	end
	
	test "a história deve existir" do
		@fh_um.historia_id = 888
		assert(!@fh_um.save)
		
		@fh_dois.historia_id = 999
		assert(!@fh_dois.save)		
	end
	
	test "a historia e a funcionalidade devem ser do mesmo produto" do
		historia_produto_um = Historia.do_produto(1).first
		funcionalidade_produto_dois = Funcionalidade.do_produto(2).first
		
		errado = FuncionalidadeHistoria.new(
			historia_id:       historia_produto_um.id,
			funcionalidade_id: funcionalidade_produto_dois.id
		)
		
		assert(!errado.save)
	end
	
	test "historia do relacionamento" do
		assert_equal(@fh_um.historia, @h_um)
		assert_equal(@fh_dois.historia, @h_doze)
	end
	
	test "funcionalidade do relacionamento" do
		assert_equal(@fh_um.funcionalidade, @f_um)
		assert_equal(@fh_dois.historia, @h_doze)
	
	end
	
	test "funcionalidades pela história" do
		assert(@h_um.respond_to?(:funcionalidades))
		assert(@h_um.funcionalidades.include?(@f_um))
		assert(@h_doze.funcionalidades.include?(@f_dois))
	end

	test "historias pela funcionalidade" do
		assert(@f_um.respond_to?(:historias))
		assert(@f_um.historias.include?(@h_um))
		assert(@f_dois.historias.include?(@h_doze))
	end
	
	test "deletar as relacoes com as funcionalidades ao deletar a historia" do
		
		assert((@h_um.funcionalidades.count > 0),'para este teste funcionar a historia deve ter funcionalidades relacionadas')
		
		@h_um.destroy
				
		assert_equal(0, FuncionalidadeHistoria.where(historia_id:@h_um.id).count)
	end

	test "deletar as relacoes com as historias ao deletar a funcionalidade" do
		
		assert((@f_dois.historias.count > 0), 'para este teste funcionar a funcionalidade deve ter historias relacionadas')
		
		@f_dois.destroy
				
		assert_equal(0, FuncionalidadeHistoria.where(funcionalidade_id:@f_dois.id).count)
	end
	
	test "funcionalidades ainda nao relacionadas" do
		todas = Funcionalidade.do_produto(@p)
		
		nao_relacinoadas = todas - @h_um.funcionalidades
		
		assert_equal(nao_relacinoadas.size, @h_um.funcionalidades_nao_relacionadas.size)
	end
end
