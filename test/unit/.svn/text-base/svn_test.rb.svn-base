# encoding: UTF-8

require 'test_helper'

class LogSvnTest < ActiveSupport::TestCase

	test "cria um arquivo do xml" do
		
		xml_str = '<path kind="file" action="M">/caminho/completo/para/meu/arquivo.txt</path>'
		
		arquivo = SVN::Arquivo.do_xml(xml_str)
		
		assert_equal('file', arquivo.tipo)
		assert_equal('M', arquivo.acao)
		assert_equal('arquivo.txt', arquivo.nome)
		assert_equal('/caminho/completo/para/meu', arquivo.diretorio)
		assert_equal('/caminho/completo/para/meu/arquivo.txt', arquivo.caminho_completo)
	end

	test "cria um arquivo do hash_xml" do
		
		xml_str = '<path kind="file" action="M">/caminho/completo/para/meu/arquivo.txt</path>'
		
		arquivo = SVN::Arquivo.do_hash_xml(ActiveSupport::XmlMini.parse(xml_str)['path'])
		
		assert_equal('file', arquivo.tipo)
		assert_equal('M', arquivo.acao)
		assert_equal('arquivo.txt', arquivo.nome)
		assert_equal('/caminho/completo/para/meu', arquivo.diretorio)
		assert_equal('/caminho/completo/para/meu/arquivo.txt', arquivo.caminho_completo)
	end
	
	test "cria um commit do xml com varios arquivos" do
		
		xml_str = '<logentry revision="1234">
			<author>usuario</author>
			<date>2011-12-15T15:58:43.301326Z</date>
			<paths>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/datas.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos_data.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/numericos.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/componentes_formulario.rb</path>
			</paths>
			<msg>mensagem do commit</msg>
		</logentry>'
		
		commit = SVN::Commit.do_xml(xml_str)
		
		assert_equal('1234', commit.revisao)
		assert_equal('usuario', commit.autor)
		assert_equal('mensagem do commit', commit.mensagem)
		assert_equal(Time.parse('2011-12-15T15:58:43.301326Z'), commit.hora)
		assert(commit.respond_to?(:arquivos),'o commit deve ter um método arquivos')
		assert_equal(5, commit.arquivos.size)
		
		commit.arquivos.each do |arquivo|
			assert_equal(SVN::Arquivo, arquivo.class)
			assert_equal(commit, arquivo.commit)
		end	
	end

	test "cria um commit do xml com um arquivo" do
		
		xml_str = '<logentry revision="1234">
			<author>usuario</author>
			<date>2011-12-15T15:58:43.301326Z</date>
			<paths>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
			</paths>
			<msg>mensagem do commit</msg>
		</logentry>'
		
		commit = SVN::Commit.do_xml(xml_str)
		
		assert_equal('1234', commit.revisao)
		assert_equal('usuario', commit.autor)
		assert_equal('mensagem do commit', commit.mensagem)
		assert_equal(Time.parse('2011-12-15T15:58:43.301326Z'), commit.hora)
		assert(commit.respond_to?(:arquivos),'o commit deve ter um método arquivos')
		assert_equal(1, commit.arquivos.size)

		arquivo = commit.arquivos.first
		assert_equal('elementos.rb', arquivo.nome)
	end
	
	test "cria um commit do hash_xml" do
		
		xml_str = '<logentry revision="1234">
			<author>usuario</author>
			<date>2011-12-15T15:58:43.301326Z</date>
			<paths>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/datas.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos_data.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/numericos.rb</path>
				<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/componentes_formulario.rb</path>
			</paths>
			<msg>mensagem do commit</msg>
		</logentry>'
		
		commit = SVN::Commit.do_hash_xml(ActiveSupport::XmlMini.parse(xml_str)['logentry'])
		
		assert_equal('1234', commit.revisao)
		assert_equal('usuario', commit.autor)
		assert_equal('mensagem do commit', commit.mensagem)
		assert_equal(Time.parse('2011-12-15T15:58:43.301326Z'), commit.hora)
		assert(commit.respond_to?(:arquivos),'o commit deve ter um método arquivos')
		assert_equal(5, commit.arquivos.size)
		
		commit.arquivos.each do |arquivo|
			assert_equal(SVN::Arquivo, arquivo.class)
			assert_equal(commit, arquivo.commit)
		end	
	end

	test "cria um log do xml com varios commits" do
		xml_str = '<?xml version="1.0"?>
		<log>
			<logentry revision="3537">
				<author>eduardo</author>
				<date>2011-12-15T16:18:23.576519Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/app/models/classificacao_fiscal.rb</path>
				</paths>
				<msg>Campo descrição é obrigatório</msg>
			</logentry>
			<logentry revision="3536">
				<author>eduardo</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/datas.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos_data.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/numericos.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/componentes_formulario.rb</path>
				</paths>
				<msg>Formatado campo informaçao</msg>
			</logentry>
		</log>'
		
		log = SVN::Log.do_xml(xml_str)
		
		assert_equal(2, log.commits.size)
		log.commits.each do |commit|
			assert(commit.is_a?(SVN::Commit))
			assert_equal(commit.log, log)
		end
	end

	test "cria um log do xml com um commits" do
		xml_str = '<?xml version="1.0"?>
		<log>
			<logentry revision="3536">
				<author>eduardo</author>
				<date>2011-12-15T15:58:43.301326Z</date>
				<paths>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/datas.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/elementos_data.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/numericos.rb</path>
					<path kind="file" action="M">/branch/sprint27/lib/formulario/componentes/componentes_formulario.rb</path>
				</paths>
				<msg>Formatado campo informaçao</msg>
			</logentry>
		</log>'
		
		log = SVN::Log.do_xml(xml_str)
		
		assert_equal(1, log.commits.size)
		commit = log.commits.first
		
		assert(commit.is_a?(SVN::Commit))
		assert_equal('eduardo', commit.autor)
		assert_equal(5, commit.arquivos.size)
		assert_equal('Formatado campo informaçao', commit.mensagem)
	end

	test "importa um super xml" do
		super_xml = File.read('test/fixtures/svn_log.xml')
		
		log = SVN::Log.do_xml(super_xml)
		
		assert_not_nil(log)
		assert(log.commits.any?)

		log.commits.each do |commit|
			assert(!commit.revisao.blank?)
		end
	end
end