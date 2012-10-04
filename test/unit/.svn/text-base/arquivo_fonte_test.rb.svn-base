# encoding: UTF-8

require 'test_helper'

class ArquivoFonteTest < ActiveSupport::TestCase
	
	setup do
		@a = arquivos_fonte(:teste_funcional_tarefa_testes_historia_dez_produto_um)
	end
	
	test "salvar com sucesso" do
		assert(@a.save)
	end
	
	test "campos obrigatorios" do
		valida_campos_obrigatorios(@a,:caminho_completo, :produto_id)
	end
	
	test "nome" do
		@a.caminho_completo = 'meu/caminho/especifico/de/teste.txt'
		assert_equal('teste.txt', @a.nome)
	end
	
	test "diretorio" do
		@a.caminho_completo = 'meu/caminho/especifico/de/teste.txt'
		assert_equal('meu/caminho/especifico/de', @a.diretorio)
	end
	
	test "produto que exista" do
		@a.produto_id = 444
		assert(!@a.save)
	end
	
end