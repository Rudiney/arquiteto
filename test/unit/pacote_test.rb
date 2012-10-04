# encoding: UTF-8

require 'test_helper'

class PacoteTest < ActiveSupport::TestCase

	setup do
		@p = pacotes(:um_produto_dois)
	end
	
	test "salvar_com_sucesso" do
		assert(@p.save)
	end
	
	test "campos obrigatórios" do
		valida_campos_obrigatorios(@p,:produto_id,:nome)
	end
	
	test "deve ter várias histórias" do
		assert_respond_to(@p,:historias)
	end
	
	test "deve ter 1 produto" do
		assert_respond_to(@p,:produto)
	end
	
	test "um produto que exista" do
		@p.produto_id = 987
		assert(!@p.save)
	end
end
