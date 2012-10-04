# encoding: UTF-8

require 'test_helper'

class CategoriaArquivoFonteTest < ActiveSupport::TestCase
	
	setup do
		@caf = categorias_arquivos_fonte(:modelos_produto_um)
	end
	
	test "deve salvar com sucesso" do
		assert @caf.save
	end
	
	test "atributos obrigatórios"	do
		valida_campos_obrigatorios(@caf,:nome, :string_expressao_regular, :produto_id)
	end
	
	test "limite dos campos" do
		@caf.nome = 'a'*256
		assert(!@caf.save, 'não pode salvar o nome tem 256')
		
		@caf.nome = 'a'*255
		assert(@caf.save, 'deve salvar pois o nome tem 255')
		
		@caf.string_expressao_regular = 'a'*255
		assert(@caf.save, 'pode salvar pois a expressao regular tem 255 erro: ' + @caf.errors.full_messages.join(','))
		
		@caf.string_expressao_regular = 'a'*256
		assert(!@caf.save, 'não deveria salvar pois a expressao regular tem 256')
	end

	test "produto deve existe" do
		@caf.produto_id = 555
		assert(!@caf.save)
	end

	test "deve ser uma expressao regular válida" do
		
		expressoes_invalidas = ['\\', '*', '[', '(', ')','?','+' ]

		expressoes_invalidas.each do |ei|
			@caf.string_expressao_regular = ei			
			assert(!@caf.save, "A expressão regular '#{ei}' é inválida e a categoria não deveria ser salva")
		end
		
	end

	test "monta a expressao regular da string" do
		assert_equal(Regexp.new(@caf.string_expressao_regular), @caf.expressao_regular)
	end

	test "não pode ter 2 expressões regulares iguais no mesmo produto" do
		outra = CategoriaArquivoFonte.new(nome: 'outro nome', produto_id: @caf.produto_id)
		outra.string_expressao_regular = @caf.string_expressao_regular
		assert(!outra.save, 'não deveria ter salvo')
		
		outra = CategoriaArquivoFonte.new(nome: 'outro nome', produto_id: 2)
		outra.string_expressao_regular = @caf.string_expressao_regular
		assert(outra.save, 'deveria salvar pois é de outro produto agora')
	end

	test "deve ter vários arquivos_fonte" do
		assert_respond_to(@caf,:arquivos_fonte)
	end
	
	test "buscar um arquivo corretamente" do
		#com base nas fixtures.
		assert_equal(20, @caf.arquivos_fonte.size)

		modelo = ArquivoFonte.new(
			caminho_completo: 'app/models/produto_um/modelo_de_teste.rb',
			produto_id: 1
		)
		assert(modelo.save, "ixi, nao salvou o arquivo fonte do modelo!")

		assert(@caf.arquivos_fonte.include?(modelo), 'não trouxe o arquivo que deveria!')
		
		modelo_errado = ArquivoFonte.new(
			caminho_completo: 'app/models/outro_produto/modelo_de_teste.rb',
			produto_id: 1
		)
		assert(modelo_errado.save, "ixi, nao salvou o arquivo fonte do modelo!")

		assert(!@caf.arquivos_fonte.include?(modelo_errado), 'trouxe o arquivo errado!')
	end

	test "a categoria está no arquivo fonte" do
		
		modelo = ArquivoFonte.new(
			caminho_completo: 'app/models/produto_um/modelo_de_teste.rb',
			produto_id: 1
		)
			
		assert_equal(1, modelo.categorias.size)
		
		assert(modelo.categorias.include?(@caf))
	end
	
	test "nao pode trazer arquivos de outros produtos" do
		modelo = ArquivoFonte.new(
			caminho_completo: 'app/models/produto_um/modelo_de_teste.rb',
			produto_id: 2
		)
		
		assert(modelo.save, "ixi, nao salvou o arquivo fonte do modelo!")
		
		assert(!@caf.arquivos_fonte.include?(modelo), "O arquivo não deve pertencer a categoria pois é de outro produto.")
	end

	test "nao pode trazer categorias de outros produtos" do
		categoria_errada = CategoriaArquivoFonte.new(
			nome: 'errada',
			string_expressao_regular: 'models/produto_um',
			produto_id: 2
		)
		assert(categoria_errada.save, "ixi, não salvou a categoria errada!")
		
		modelo = ArquivoFonte.new(
			caminho_completo: 'app/models/produto_um/modelo_de_teste.rb',
			produto_id: 1
		)
		assert(modelo.save, "ixi, nao salvou o arquivo fonte do modelo!")
		
		assert_equal(1, modelo.categorias.size,'o modelo só deve ter 1 categoria!')
		
		assert(!modelo.categorias.include?(categoria_errada), "a categoria errada nao devia estar relacionada no modelo poque é de outro produto")
	end
end
