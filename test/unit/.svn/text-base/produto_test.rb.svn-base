# encoding: UTF-8

require 'test_helper'

class ProdutoTest < ActiveSupport::TestCase
	
	setup do
		@produto = produtos(:um)
	end
	
	test "deve salvar com sucesso" do
		assert @produto.save
	end
	
	test "o nome do produto deve ser prenchido"	do
		valida_campos_obrigatorios(@produto,:nome)
	end
	
	test "deve ter várias funcionalidades" do
		assert_respond_to(@produto,:funcionalidades)
	end
	
	test "remover todas as funcionalidades de um produto ao remover o produto" do 
		assert((@produto.funcionalidades.count > 0), "para este teste funcionar o produto deve ter funcionalidades")
		
		@produto.destroy
		
		assert(Funcionalidade.do_produto(@produto).count == 0, "depois que deletei um produto, ainda ficaram funcionalidades deste produto no banco de dados")
	end
	
	test "remover todas as historias de um produto ao remover o produto" do 
		assert((@produto.historias.count > 0), "para este teste funcionar o produto deve ter historias")
		
		@produto.destroy
		
		assert(Historia.do_produto(@produto).count == 0, "depois que deletei um produto, ainda ficaram historias deste produto no banco de dados")
	end

	test "remover o repositorio ao remover o produto" do
		assert_not_nil(@produto.repositorio,'para este teste funcionar o produto deve ter um repositorio')
		@produto.destroy
		assert(Repositorio.where(produto_id:@produto.id).empty?)
	end

	test "remover os arquivos ao remover o produto" do
		assert_not_nil(@produto.arquivos_fonte,'para este teste funcionar o produto deve ter arquivos fonte')
		@produto.destroy
		assert(ArquivoFonte.where(produto_id:@produto.id).empty?)
	end
	
	test "remover as categorias ao remover o produto" do
		assert_not_nil(@produto.categorias_arquivos_fonte,'para este teste funcionar o produto deve ter categorias de arquivos fonte')
		@produto.destroy
		assert(CategoriaArquivoFonte.where(produto_id:@produto.id).empty?)
	end
end
