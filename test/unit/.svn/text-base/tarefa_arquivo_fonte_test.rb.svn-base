# encoding: UTF-8

require 'test_helper'

class TarefaArquivoFonteTest < ActiveSupport::TestCase
	
	setup do
		@p = produtos(:um)
		
		@hum_pum = historias(:oito_produto_um)
		@tum_pum = tarefas(:testes_historia_oito_produto_um)
		@afum_pum = arquivos_fonte(:teste_unitario_tarefa_testes_historia_oito_produto_um)
		@taf_um = tarefas_arquivos_fonte(:teste_unitario_tarefa_testes_historia_oito_produto_um)
		
		@hdois_pdois = historias(:doze_produto_dois)
		@tdois_pdois = tarefas(:codificacao_historia_doze_produto_dois)
		@afdois_pdois = arquivos_fonte(:controller_tarefa_codificacao_historia_doze_produto_dois)
		@taf_dois = tarefas_arquivos_fonte(:controller_tarefa_codificacao_historia_doze_produto_dois)
	end
	
	test "salvar as fixtures com sucesso" do
		assert(@taf_um.save)
		assert(@taf_dois.save)
	end
	
	test "uma tarefa e um um arquivo fonte são obrigatórios" do
		@taf_um.tarefa_id = nil
		assert(!@taf_um.save)
		
		@taf_dois.arquivo_fonte_id = nil
		assert(!@taf_dois.save)
	end

	test "não pode haver 2 relacionamentos iguais" do
		duplicado = TarefaArquivoFonte.new(@taf_um.attributes)
		assert(!duplicado.save)
		
		duplicado = TarefaArquivoFonte.new(@taf_dois.attributes)
		assert(!duplicado.save)
	end
	
	test "a tarefa deve existir" do
		@taf_um.tarefa_id = 875
		assert(!@taf_um.save)
		
		@taf_dois.tarefa_id = 888
		assert(!@taf_dois.save)
	end
	
	test "o arquivo fonte deve existir" do
		@taf_um.arquivo_fonte_id = 875
		assert(!@taf_um.save)
		
		@taf_dois.arquivo_fonte_id = 888
		assert(!@taf_dois.save)
	end

	test "o arquivo e a tarefa devem ser do mesmo produto" do
		@taf_um.arquivo_fonte_id = @afdois_pdois.id
		assert(!@taf_um.save)
		
		@taf_dois.tarefa_id = @tum_pum.id
		assert(!@taf_dois.save)
	end
	
	test "tarefa do relacionamento" do
		assert_equal(@tum_pum, @taf_um.tarefa)
		assert_equal(@tdois_pdois, @taf_dois.tarefa)
	end
	
	test "arquivo fonte do relacionamento" do
		assert_equal(@afum_pum, @taf_um.arquivo_fonte)
		assert_equal(@afdois_pdois, @taf_dois.arquivo_fonte)
	end

	test "arquivos pela tarefa" do
		assert(@tum_pum.respond_to?(:arquivos_fonte))
		assert(@tdois_pdois.arquivos_fonte.include?(@afdois_pdois))
		assert(@tum_pum.arquivos_fonte.include?(@afum_pum))
	end

	test "tarefas pelo arquivo" do
		assert(@afum_pum.respond_to?(:tarefas))
		assert(@afum_pum.tarefas.include?(@tum_pum))
		assert(@afdois_pdois.tarefas.include?(@tdois_pdois))		
	end

	test "deletar os relacioamentos ao deletar a tarefa" do
		assert(@tum_pum.tarefas_arquivos_fonte.any?, "para este teste funcionar a tarefa deve ter arquivos fonte")
		@tum_pum.destroy
		assert_equal(0, TarefaArquivoFonte.where(tarefa_id: @tum_pum.id).count)
	end
	
	test "deletar os relacioamentos ao deletar o arquivo fonte" do
		assert(@afdois_pdois.tarefas_arquivos_fonte.any?, "para este teste funcionar o arquivo fonte deve ter tarefas")
		@afdois_pdois.destroy
		assert_equal(0, TarefaArquivoFonte.where(arquivo_fonte_id: @afdois_pdois.id).count)
	end
	
	test "historias do arquivo fonte" do
		assert_equal(1, @afum_pum.historias.size)
		@afum_pum.tarefas.each do |t|
			assert(@afum_pum.historias.include?(t.historia), "O método historias do arquivo fonte não trouxe corretamente a historia #{t.historia.id}")
		end
	end
	
	test "funcionalidades do arquivo fonte" do
		assert_equal(1, @afum_pum.funcionalidades.size)
		@afum_pum.tarefas.each do |t|
			t.historia.funcionalidades.each do |f|
				assert(@afum_pum.funcionalidades.include?(f),"O método funcionalidades do arquivo fonte não trouxe corretamente a funcionalidade #{f.id}")
			end
		end
	end
end
