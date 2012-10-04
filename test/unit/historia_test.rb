# encoding: UTF-8

require 'test_helper'

class HistoriaTest < ActiveSupport::TestCase

	setup do
		@p = produtos(:dois)
		@h = historias(:um_produto_dois)
	end

	test "salvar_com_sucesso" do
		assert(@h.save)
	end
	
	test "campos obrigatórios" do
		valida_campos_obrigatorios(@h,:produto_id,:nome,:situacao)
	end
	
	test "o nome deve ter até 255 caracteres" do
		@h.nome = 'a'*255
		assert(@h.save)
		
		@h.nome = 'a'*256
		assert(!@h.save)
	end
	
	test "uma situacao que exista" do
		[10,20,30,40].each do |situacao_existente|
			@h.situacao = situacao_existente
			assert(@h.save)			
		end
		
		[55,5,12,100].each do |situacao_inexistente|
			@h.situacao = situacao_inexistente
			assert(!@h.save)
		end
	end
		
	test "um produto que exista" do
		@h.produto_id = 987
		assert(!@h.save)
	end

	test "descrição padrão" do
		h = Historia.new
		assert_equal("Como um [usuario] gostaria de [funcionalidade] para [objetivo]", h.descricao)
	end
	
	test "descrição diferente do padrao ao criar a historia" do
		atributos = @h.attributes
		atributos[:descricao] = 'personalizada'
		
		h = Historia.new(atributos)
		
		assert_equal('personalizada', h.descricao)
	end
	
	test "escopo do produto" do
		quantidade = Historia.where(produto_id: 1).count
		
		historias_do_produto = Historia.do_produto(1)
		
		assert_equal(quantidade, historias_do_produto.count)
		
		historias_do_produto.each do |h|
			assert_equal(h.produto_id, 1)
		end
	end
	
	test "historias do produto" do
		assert_equal(Historia.do_produto(@p).count, @p.historias.count)
	end
	
	test "nomes das situacoes" do
		situacoes = {
			10 => 'incompleta',
			20 => 'aguardando',
			30 => 'iniciada',
			40 => 'pronta'
		}
		
		situacoes.each do |codigo,nome|
			@h.situacao = codigo
			assert_equal(nome, @h.situacao_nome.to_s)
		end
	end

	test "escopo por uma situacao" do
		
		assert_equal(0, Historia.na_situacao(:inexistente).count)
		
		quantidade            = Historia.where(situacao: 10).count
		historias_pelo_escopo = Historia.na_situacao(:incompleta)
		
		assert_equal(quantidade, historias_pelo_escopo.count)
		historias_pelo_escopo.each do |h|
			assert_equal(h.situacao, 10)
		end
		
		historias_pelo_escopo = Historia.na_situacao(10)
		
		assert_equal(quantidade, historias_pelo_escopo.count)
		historias_pelo_escopo.each do |h|
			assert_equal(h.situacao, 10)
		end
		
	end
	
	test "escopo por várias situações" do
		correto = Historia.where(situacao: [10,20])
		pelo_escopo = Historia.na_situacao(:incompleta, :aguardando)
		
		assert_equal(correto.count, pelo_escopo.count)
		correto.each do |hc|
			assert(pelo_escopo.include?(hc))
		end
		
		pelo_escopo = Historia.na_situacao(10,20)
		
		assert_equal(correto.count, pelo_escopo.count)
		correto.each do |hc|
			assert(pelo_escopo.include?(hc))
		end
	end

	test "remover suas tarefas ao remover a historia" do
		assert(@h.tarefas.any?, "para este teste funcionar a história deve ter tarefas")
		
		@h.destroy
		
		assert(Tarefa.where(historia_id: @h).empty?)
	end

	test "arquivos fonte pela historia" do
		assert(@h.respond_to?(:arquivos_fonte))
		
		@h.tarefas.each do |t|
			t.arquivos_fonte.each do |af|
				assert(@h.arquivos_fonte.include?(af))
			end
		end
	end
	
	test "valores válidos para os campos do tamanho da história" do
		[:complexidade_negocio, :complexidade_interface, :esforco, :risco].each do |campo|
			[1,2,3,5,8].each do |t|
				@h[campo] = t
				assert(@h.valid?, "a história deveria ser válida com #{campo} = #{t}. Erro: #{@h.errors.full_messages}")
			end			
		end
	end
	
	test "valores in válidos para os campos do tamanho da história" do
		[:complexidade_negocio, :complexidade_interface, :esforco, :risco].each do |campo|
			[-4,-1,4,6,7,10].each do |t|
				@h[campo] = t
				assert(!@h.valid?, "a história não deveria ser válida com #{campo} = #{t}")
			end
		end
	end
	
	test "calculando o tamanho correto da história" do
		assert_equal((@h.complexidade_negocio + @h.complexidade_interface + @h.esforco + @h.risco), @h.tamanho)
	end

	test "pode ter um pacote" do
		pacote = pacotes(:dois_produto_dois)
		@h.pacote = pacote
		assert(@h.save)
	end
	
	test "nao pode ter um pacote de outro produto" do
		pacote = pacotes(:um_produto_um)
		@h.pacote = pacote
		assert(!@h.save)
	end

	test "um pacote que exista" do
		@h.pacote_id = 77777
		assert(!@h.save)
	end

end
