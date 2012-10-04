# encoding: UTF-8

require 'test_helper'

class RepositorioTest < ActiveSupport::TestCase
	
	setup do
		@p         = produtos(:um)
		@repo      = repositorios(:produto_um)
		@repo_dois = repositorios(:produto_dois)
	end
	
	test "deve salvar com sucesso" do
		assert(@repo.save)
	end
	
	test "campos obrigatórios" do
		valida_campos_obrigatorios(@repo,:endereco, :produto_id)
	end
	
	test "deve ter um produto que exista" do
		
		assert_equal(@repo.produto, @p)
		
		@repo.produto_id = 546
		assert(!@repo.save)
	end

	test "não pode ter 2 repositorios para o mesmo produto" do
		
		outro_repo = Repositorio.new(@repo_dois.attributes)
		outro_repo.produto_id = @repo.produto_id
		
		assert(!outro_repo.save)
	end
	
	test "o endereço só pode ter até 255 caracteres" do
		
		@repo.endereco = 'a'*255
		assert(@repo.save)
		
		@repo.endereco = 'a'*256
		assert(!@repo.save)
	end		

	test "comando bsucar log xml" do
		assert_equal("svn log #{@repo.endereco} --xml --verbose -r HEAD:#{@repo.ultima_revisao_importada}", @repo.comando_buscar_log_xml)
	end

	test "xml de log do repositorio" do

		xml_log_por_fora = `#{@repo.comando_buscar_log_xml}`

		assert_equal(xml_log_por_fora, @repo.log_xml)
		
	end
			
end
