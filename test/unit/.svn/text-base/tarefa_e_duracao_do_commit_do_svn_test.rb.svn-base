# encoding: UTF-8

require 'test_helper'

class TarefaEDuracaoDoCommitDoSvnTest < ActiveSupport::TestCase
	
	setup do
		@commit = SVN::Commit.new()
		@tum   = tarefas(:codificacao_historia_dois_produto_dois)
		@tdois = tarefas(:integrar_historia_doze_produto_dois)
	end
	
	test "tarefa" do
		@commit.mensagem = "{t:#{@tum.identificador}} este commit tem 1 tarefa"
		assert_equal(@tum, @commit.tarefa, "Não trouxe a tarefa certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t:#{@tdois.identificador}} este commit tem 1 tarefa"
		assert_equal(@tdois, @commit.tarefa, "Não trouxe a tarefa certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t:#{@tum.identificador}}deve funcionar"
		assert_equal(@tum, @commit.tarefa, "Não trouxe a tarefa certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t:#{@tdois.identificador}}{tem que funcionar}"
		assert_equal(@tdois, @commit.tarefa, "Não trouxe a tarefa certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{ t:#{@tum.identificador} } este commit tem 1 tarefa"
		assert_equal(@tum, @commit.tarefa, "Não trouxe a tarefa certa com a mensagem #{@commit.mensagem}")

		@commit.mensagem = "{t: #{@tdois.identificador}} este commit tem 1 tarefa"
		assert_equal(@tdois, @commit.tarefa, "Não trouxe a tarefa certa com a mensagem #{@commit.mensagem}")

	end
		
	test "sem tarefa" do
		@commit.mensagem = "este commit nao tem tarefa"
		assert_equal(nil, @commit.tarefa, "o commit de mensagem #{@commit.mensagem} não podia ter uma tarefa!")
		
		@commit.mensagem = "{este} commit nao tem tarefa"
		assert_equal(nil, @commit.tarefa, "o commit de mensagem #{@commit.mensagem} não podia ter uma tarefa!")

		@commit.mensagem = "[] commit nao tem tarefa"
		assert_equal(nil, @commit.tarefa, "o commit de mensagem #{@commit.mensagem} não podia ter uma tarefa!")
		
		@commit.mensagem = "[t:#{@tum.identificador}] commit nao tem tarefa"
		assert_equal(nil, @commit.tarefa, "o commit de mensagem #{@commit.mensagem} não podia ter uma tarefa!")
		
		@commit.mensagem = "{y:#{@tum.identificador}} commit nao tem tarefa"
		assert_equal(nil, @commit.tarefa, "o commit de mensagem #{@commit.mensagem} não podia ter uma tarefa!")
		
		@commit.mensagem = "{t : #{@tdois.identificador}} este commit não pode ter 1 tarefa"
		assert_equal(nil, @commit.tarefa, "o commit de mensagem #{@commit.mensagem} não podia ter uma tarefa!")

		@commit.mensagem = "{t:98765} este commit não pode ter 1 tarefa"
		assert_equal(nil, @commit.tarefa, "o commit de mensagem #{@commit.mensagem} não podia ter uma tarefa!")

	end

	test "com tarefa e duração" do
		@commit.mensagem = "{t:#{@tum.identificador}, d:1} este commit tem 1 tarefa"
		assert_equal('1H'.em_segundos, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t:#{@tdois.identificador}, d:1:45} este commit tem 1 tarefa"
		assert_equal('1:45'.em_segundos, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t:#{@tum.identificador}, d: 1:10} este commit tem 1 tarefa"
		assert_equal('1:10'.em_segundos, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t:#{@tdois.identificador}, d:1:05 } este commit tem 1 tarefa"
		assert_equal('1:05'.em_segundos, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
	end

	test "sem tarefa nao tem duração" do
		@commit.mensagem = "{y:#{@tum.identificador}, d:1} este commit tem 1 tarefa"
		assert_equal(nil, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t : #{@tdois.identificador}, d:1:45} este commit tem 1 tarefa"
		assert_equal(nil, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{t:asdf, d: 1:10} este commit tem 1 tarefa"
		assert_equal(nil, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
		
		@commit.mensagem = "{ d:1:05 } este commit tem 1 tarefa"
		assert_equal(nil, @commit.duracao, "Não trouxe a duração certa com a mensagem #{@commit.mensagem}")
	end


end