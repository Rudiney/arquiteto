# encoding: UTF-8

require 'test_helper'

class AgrupaArquivosFontePorCategoriaTest < ActiveSupport::TestCase
	setup do
		@f = funcionalidades(:cinco_produto_dois)
	end
	
	test "deve ter o mesmo número de arquivos" do
		arquivos_agrupados = @f.arquivos_fonte_agrupados_por_categoria.values.flatten.uniq
		assert_equal(@f.arquivos_fonte.size, arquivos_agrupados.size)
	end
	
	test "cada arquivo esta no grupo correto" do
		@f.arquivos_fonte_agrupados_por_categoria.each do |cat,arquivos_fonte|
			arquivos_fonte.each do |af|
				if cat.nil?
					assert(af.categorias.empty?, "no grupo dos arquivos fonte sem categoria ficou o arquivo fonte #{af.caminho_completo} que tem categoria(s)! categorias do arquivo:#{af.categorias.collect(&:nome).join(',')}")
				else
					assert(af.categorias.include?(cat), "o arquivo fonte #{af.caminho_completo} está no grupo da categoria #{cat.nome} mas nao tem essa categoria!. categorias do arquivo:#{af.categorias.collect(&:nome).join(',')}")
				end
			end
		end
	end
	
	test "deve ter 1 grupo para cada uma das categorias dos arquivos" do
		categorias_dos_arquivos = @f.arquivos_fonte.map(&:categorias).flatten.uniq
		
		categorias_dos_arquivos.each do |categoria|
			assert(!@f.arquivos_fonte_agrupados_por_categoria[categoria].blank?, "Nos arquivos agrupado deveria ter um grupo para a categoria #{categoria.nome} mas não tem!")
		end
	end
end
