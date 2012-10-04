# encoding: UTF-8

require 'test_helper'

class ImportaArquivosRepositorioIdentificandoTarefasTest < ActiveSupport::TestCase
	
	setup do
		@repositorio = repositorios(:produto_dois)
		
		@tarefa_um = tarefas(:codificacao_historia_dois_produto_dois)
		@tarefa_um.arquivos_fonte.destroy_all
		@tarefa_um.reload
		
		@tarefa_dois = tarefas(:integrar_historia_doze_produto_dois)
		@tarefa_dois.arquivos_fonte.destroy_all
		@tarefa_dois.reload
	end


	test "só a tarefa" do
			
		xml_str = "<?xml version=\"1.0\"?>
		<log>
			<logentry revision=\"3536\">
				<author>Testador</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
				</paths>
				<msg>{t:#{@tarefa_um.identificador}}</msg>
			</logentry>
		</log>"
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		
		importacao.importa!
		
		assert_equal(1, importacao.arquivos_importados.size)
		assert_equal(1, @tarefa_um.arquivos_fonte.size)
		
		arquivo = @tarefa_um.arquivos_fonte.first
		
		assert_equal(@repositorio.produto, arquivo.produto)
		assert_equal('elementos.rb', arquivo.nome)
		assert_equal('/branch/sprint27/lib/formulario/componentes/elementos.rb', arquivo.caminho_completo)
	end

	test "varios arquivos para a tarefa" do
				
		xml_str = "<?xml version=\"1.0\"?>
		<log>
			<logentry revision=\"3536\">
				<author>Testador</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/um.rb</path>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/dois.rb</path>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/tres.rb</path>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/quatro.rb</path>
				</paths>
				<msg>{t:#{@tarefa_dois.identificador}}</msg>
			</logentry>
		</log>"
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		importacao.importa!
		
		assert_equal(4, @tarefa_dois.arquivos_fonte.count, "depois de importação a tarefa deveria ter 4 arquvos")
		
		importacao.arquivos_importados.each do |ai|
			assert(@tarefa_dois.arquivos_fonte.include?(ai),"a tarefa deveria ter o arquivo fonte #{ai.caminho_completo}")
		end
	end
	
	test "não pode importar 2 vezes o mesmo arquivo para a mesma tarefa" do
		
		xml_str = "<?xml version=\"1.0\"?>
		<log>
			<logentry revision=\"3536\">
				<author>Testador</author><date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/um.rb</path>
				</paths>
				<msg>{t:#{@tarefa_um.identificador}} primeiro commit nessa tarefa</msg>
			</logentry>
			<logentry revision=\"3537\">
				<author>Testador</author><date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/um.rb</path>
				</paths>
				<msg>{t:#{@tarefa_um.identificador}} segundo commit do mesmo arquivo na tarefa</msg>
			</logentry>			
		</log>"
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		
		assert_difference("ArquivoFonte.count", +1)do
			importacao.importa!  
		end
		
		assert_equal(1, @tarefa_um.arquivos_fonte.count)
		assert_equal(1, importacao.arquivos_importados.size)
	end
	
	test "1 arquivo em duas tarefas" do
		
		xml_str = "<?xml version=\"1.0\"?>
		<log>
			<logentry revision=\"3536\">
				<author>Testador</author><date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/um.rb</path>
				</paths>
				<msg>{t:#{@tarefa_um.identificador}} o arquivo na tarefa um</msg>
			</logentry>
			<logentry revision=\"3537\">
				<author>Testador</author><date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind=\"file\" action=\"M\">/branch/sprint27/lib/formulario/componentes/um.rb</path>
				</paths>
				<msg>{t:#{@tarefa_dois.identificador}} o mesmo arquivo na tarefa 2</msg>
			</logentry>			
		</log>"
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		
		assert_difference("ArquivoFonte.count", +1) do
			assert_difference("TarefaArquivoFonte.count", +2) do
				importacao.importa!
			end
		end
		
		assert_equal(1, @tarefa_um.arquivos_fonte.count, "A tarefa 1 deveria ter 1 arquivo fonte")
		assert_equal(1, @tarefa_dois.arquivos_fonte.count, "A tarefa 2 deveria ter 1 arquivo fonte")
		assert_equal(1, importacao.arquivos_importados.size)
		
	end
	
end