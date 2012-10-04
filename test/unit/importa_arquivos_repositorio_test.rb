# encoding: UTF-8

require 'test_helper'

class ImportaArquivosRepositorioTest < ActiveSupport::TestCase
	
	setup do
		@repositorio = repositorios(:produto_dois)
		@tarefa_um   = tarefas(:codificacao_historia_dois_produto_dois)
		@tarefa_dois = tarefas(:integrar_historia_doze_produto_dois)
	end
	
	test "deve ter um repositorio para importar" do
		assert_raise(RuntimeError){ 
			importacao = ImportaArquivosRepositorio.new()			
		}
	end
	
	test "o log padrao da importacao é o log do repositorio" do
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio)
		
		assert_equal(@repositorio.log_xml, importacao.log_xml)
	end
	
	test "log da importacao diferente do log do repositorio" do
		outro_log = 'qualquer outro log em xml'
		
		importacao = ImportaArquivosRepositorio.new(
			repositorio: @repositorio,
			log_xml: outro_log
		)
		
		assert_equal(outro_log, importacao.log_xml)
	end
	
	test "importa 1 commit 1 arquivo" do
		
		xml_str = '<?xml version="1.0"?>
		<log>
			<logentry revision="3536">
				<author>eduardo</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
				</paths>
				<msg>Formatado campo informaçao</msg>
			</logentry>
		</log>'
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		
		assert_difference("ArquivoFonte.count", +1) do
			importacao.importa!		  
		end
		
		assert_equal(1, importacao.arquivos_importados.size)
		
		arquivo = importacao.arquivos_importados.first
		
		assert_equal(@repositorio.produto, arquivo.produto)
		assert_equal('elementos.rb', arquivo.nome)
		assert_equal('/branch/sprint27/lib/formulario/componentes/elementos.rb', arquivo.caminho_completo)
	end

	test "importa 1 commit vários arquivos" do
		
		xml_str = '<?xml version="1.0"?>
		<log><logentry revision="3530">
			<author>eduardo</author>
			<date>2011-12-15T12:18:21.815581Z</date>
			<paths>
				<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/new.html.erb</path>
				<path kind="file" action="M">/branch/sprint27/app/views/desktop/mensagens.html.erb</path>
				<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/show.html.erb</path>
				<path kind="file" action="M">/branch/sprint27/app/views/classificacoes_fiscais/_campos_formulario.html.erb</path>
				<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/delete.html.erb</path>
				<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/edit.html.erb</path>
				<path kind="file" action="M">/branch/sprint27/app/models/classificacao_fiscal.rb</path>
			</paths>
			<msg>[h:165, t:3] Criado cadastro de Classificação fiscal e corrigido retorno de mensagem de erro.</msg>
			</logentry>
		</log>'
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		
		assert_difference("ArquivoFonte.count", +7) do
			importacao.importa!		  
		end
		
		assert_equal(7, importacao.arquivos_importados.size)
		
		importacao.arquivos_importados.each do |arquivo_importado|
			assert_equal(@repositorio.produto, arquivo_importado.produto)
		end
		
	end
	
	test "importa vários commits vários arquivos" do
	
		xml_str = '<?xml version="1.0"?>
		<log>
			<logentry revision="3531">
				<author>felipe</author>
				<date>2011-12-15T13:25:10.961409Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
					<path kind="file" action="M">/branch/sprint27/public/javascripts/desktop/overrides.js</path>
					<path kind="file" action="M">/branch/sprint27/app/controllers/application_controller.rb</path>
					<path kind="file" action="M">/branch/sprint27/app/models/configura_atributos.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/componentes_formulario.rb</path>
				</paths>
				<msg>Corrigido bug de codificação ao utilizar o editor.</msg>
			</logentry>
			<logentry revision="3530">
				<author>eduardo</author>
				<date>2011-12-15T12:18:21.815581Z</date>
				<paths>
					<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/new.html.erb</path>
					<path kind="file" action="M">/branch/sprint27/app/views/desktop/mensagens.html.erb</path>
					<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/show.html.erb</path>
					<path kind="file" action="M">/branch/sprint27/app/views/classificacoes_fiscais/_campos_formulario.html.erb</path>
					<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/delete.html.erb</path>
					<path kind="file" action="A">/branch/sprint27/app/views/classificacoes_fiscais/edit.html.erb</path>
					<path kind="file" action="M">/branch/sprint27/app/models/classificacao_fiscal.rb</path>
				</paths>
				<msg>[h:165, t:3] Criado cadastro de Classificação fiscal e corrigido retorno de mensagem de erro.</msg>
			</logentry>
			<logentry revision="3529">
				<author>daiani</author>
				<date>2011-12-15T11:53:24.451721Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/app/views/origens_mercadorias/_campos_formulario.html.erb</path>
				</paths>
				<msg>Removido espaços adicionais no código</msg>
				</logentry>
		</log>'
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		
		assert_difference("ArquivoFonte.count", +13) do
			importacao.importa!		  
		end

		assert_equal(13, importacao.arquivos_importados.size)
		
		importacao.arquivos_importados.each do |arquivo_importado|
			assert_equal(@repositorio.produto, arquivo_importado.produto)
		end
			
	end

	test "nao importar arquivos duplicados" do

		xml_str = '<?xml version="1.0"?>
		<log>
			<logentry revision="3531">
				<author>felipe</author>
				<date>2011-12-15T13:25:10.961409Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
					<path kind="file" action="M">/branch/sprint27/public/javascripts/desktop/overrides.js</path>
				</paths>
				<msg>Corrigido bug de codificação ao utilizar o editor.</msg>
			</logentry>
			<logentry revision="3530">
				<author>eduardo</author>
				<date>2011-12-15T12:18:21.815581Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
				</paths>
				<msg>[h:165, t:3] Criado cadastro de Classificação fiscal e corrigido retorno de mensagem de erro.</msg>
			</logentry>
			<logentry revision="3529">
				<author>daiani</author>
				<date>2011-12-15T11:53:24.451721Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/public/javascripts/desktop/overrides.js</path>
				</paths>
				<msg>Removido espaços adicionais no código</msg>
				</logentry>
		</log>'
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		
		assert_difference( "ArquivoFonte.count", +2) do
  			importacao.importa!
		end

		assert_equal(2, importacao.arquivos_importados.size)
		
	end

	test "arquivos iguais em produtos diferentes" do
		
		xml_str = '<?xml version="1.0"?>
		<log>
			<logentry revision="3536">
				<author>eduardo</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
				</paths>
				<msg>Formatado campo informaçao</msg>
			</logentry>
		</log>'
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		assert_difference("ArquivoFonte.count", +1) do
			importacao.importa!		  
		end
		
		assert_equal(1, importacao.arquivos_importados.size)

		# importa denovo o mesmo log em outro repositorio
		outro_repo = repositorios(:produto_um)

		importacao = ImportaArquivosRepositorio.new(repositorio: outro_repo, log_xml: xml_str)
		
		assert_difference("ArquivoFonte.count", +1) do
			importacao.importa!		  
		end
		
		assert_equal(1, importacao.arquivos_importados.size)
	end

	test "atualizar a aultima revisao importada" do
		
		xml_str = '<?xml version="1.0"?>
		<log>
			<logentry revision="1000">
				<author>eduardo</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths><path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path></paths>
				<msg>Formatado campo informaçao</msg>
			</logentry>
			<logentry revision="1001">
				<author>eduardo</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths><path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path></paths>
				<msg>Formatado campo informaçao</msg>
			</logentry>
			<logentry revision="1002">
				<author>eduardo</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths><path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path></paths>
				<msg>Formatado campo informaçao</msg>
			</logentry>
		</log>'
		
		importacao = ImportaArquivosRepositorio.new(repositorio: @repositorio, log_xml: xml_str)
		importacao.importa!
		
		assert_equal(1002, @repositorio.ultima_revisao_importada)
	end
end