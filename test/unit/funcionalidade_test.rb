# encoding: UTF-8

require 'test_helper'

class FuncionalidadeTest < ActiveSupport::TestCase

	setup do
		@f = funcionalidades(:um_produto_um)
	end
	
	test "deve salvar com sucesso" do
		assert @f.save
	end
	
	test "campos obrigatórios" do		
		valida_campos_obrigatorios(@f,:nome,:produto_id)
	end

	test "a funcionalidade deve ter um produto que existe" do
		@f.produto_id = 876
		assert(!@f.save)
	end
	
	test "nome para o artigo na wiki" do
		@f.nome = 'Nome de Teste'
		assert_equal("Funcionalidade #{@f.id}: Nome_de_Teste", @f.nome_artigo_wiki)
	end

	test "url padrão para artigo na wiki" do
		@f.url_artigo_wiki = ''
		assert(@f.save)
		assert_equal((@f.produto.url_base_wiki + @f.nome_artigo_wiki), @f.url_artigo_wiki)
	end

	test "url customizada para artigo na wiki" do
		@f.url_artigo_wiki = 'minha_url_especifica'
		assert(@f.save)
		assert_equal('minha_url_especifica',@f.url_artigo_wiki)
	end
	
	test "scopo para filtrar um produto" do
		p = produtos(:um)
		assert_equal(Funcionalidade.where(produto_id: p), Funcionalidade.do_produto(p))
	end
	
	test "arquivos fonte pela funcionalidade" do
		
		assert(@f.respond_to?(:arquivos_fonte))
		
		qtde_total = 0
		@f.historias.each do |h|
			h.tarefas.each do |t|
				t.arquivos_fonte.each do |af|
					qtde_total += 1
					assert(@f.arquivos_fonte.include?(af),"A funcionalidade deveria ter o arquivo #{af.id}")
				end
			end
		end
		
		assert_equal(qtde_total, @f.arquivos_fonte.size)
	end
end
