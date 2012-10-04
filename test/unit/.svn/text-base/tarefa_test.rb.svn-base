# encoding: UTF-8

require 'test_helper'

class TarefaTest < ActiveSupport::TestCase

	setup do
		@h = historias(:um_produto_dois)
		@t = tarefas(:integrar_historia_um_produto_dois)
	end

	test "salvar_com_sucesso" do
		assert(@t.save, "erros: #{@t.errors.full_messages.join(', ')}")
	end

	test "campos obrigatórios" do
		valida_campos_obrigatorios(@t,:historia_id,:descricao)
	end

	test "a descricao deve ter até 255 caracteres" do
		@t.descricao = 'a'*255
		assert(@t.save, 'deveria salvar')

		@t.descricao = 'a'*256
		assert(!@t.save, 'nao deveria salvar')
	end

	test "uma historia que exista" do
		@t.historia_id = 999
		assert(!@t.save)
	end

	test "buscar tarefas pela história" do
		assert(@h.respond_to?(:tarefas))
		assert(@t.respond_to?(:historia))

		@t.historia.tarefas.each do |ts|
			assert_equal(ts.historia, @t.historia)
		end
	end

	test "identificador" do
		Tarefa.all.each do |t|
			assert_equal("#{t.historia.id}.#{t.id}", t.identificador)
		end
	end

	test "tempo estimado e real" do
		
		@t.tempo_estimado = '1:40'
		assert_equal('1:40'.em_segundos, @t.segundos_estimados)
		
		assert_equal('1:40', @t.tempo_estimado)
		
		@t.tempo_real = '2:50'
		assert_equal('2:50'.em_segundos, @t.segundos_reais)
		assert_equal('2:50', @t.tempo_real)
	end
	
	test "tempo estimado da historia" do
		correto = @h.tarefas.sum(:segundos_estimados)	
		assert_equal(correto,@h.segundos_estimados)
		assert_equal(correto.em_horas,@h.tempo_estimado)
	end

	test "tempo real da historia" do
		correto = @h.tarefas.sum(:segundos_reais)	
		
		assert_equal(correto,@h.segundos_reais)
		assert_equal(correto.em_horas,@h.tempo_real)
	end
	
	test "segundos de diferenca da estimativa" do
		assert_equal((@t.segundos_estimados - @t.segundos_reais), @t.segundos_diferenca_estimativa)
		assert_equal((@h.segundos_estimados - @h.segundos_reais), @h.segundos_diferenca_estimativa)
	end

	test "diferenca da estimativa" do
		assert_equal((@t.segundos_estimados - @t.segundos_reais).em_horas, @t.diferenca_estimativa)
		assert_equal((@h.segundos_estimados - @h.segundos_reais).em_horas, @h.diferenca_estimativa)
	end
	
	test "produto da tarefa" do
		assert_equal(@h.produto, @t.produto)
	end
end