# encoding: UTF-8

require 'test_helper'

class RelacaoFuncionalidadeTest < ActiveSupport::TestCase

	setup do	
		#f=funcionalidade
		#p=produto
		#r=relacionamento
		# fum = funcionalidade um
		# fum_pum = funcionaliade um do produto um
		# ...

		@fum_pum            = funcionalidades(:um_produto_um)
		@fdois_pum          = funcionalidades(:dois_produto_um)
		@fcinco_pum         = funcionalidades(:cinco_produto_um)
		@fum_pdois          = funcionalidades(:um_produto_dois)
		@fdois_pdois        = funcionalidades(:dois_produto_dois)
		@fcinco_pdois       = funcionalidades(:cinco_produto_dois)
		@r_fum_fcinco_pum   = relacao_funcionalidades(:entre_um_e_cinco_produto_um)
		@r_fum_fcinco_pdois = relacao_funcionalidades(:entre_um_e_cinco_produto_dois)
	end

	test "criar um relacionamento com sucesso" do
		assert(@r_fum_fcinco_pum.save)
		assert(@r_fum_fcinco_pdois.save)
	end

	test "atributos obrigatórios" do
		[:funcionalidade_um, :funcionalidade_dois, :relacao].each do |att|
			valor_antigo = @r_fum_fcinco_pum.send(att)
			@r_fum_fcinco_pum.send("#{att}=",nil)
			assert(!@r_fum_fcinco_pum.save,"Não deveria deixar salvar a relação sem #{att}")
			@r_fum_fcinco_pum.send("#{att}=",valor_antigo)
		end
	end

	test "tipos de relação" do
		
		assert(@r_fum_fcinco_pum.save,   "deveria salvar 1: #{@r_fum_fcinco_pum.errors.full_messages.join(', ')}")
		assert(@r_fum_fcinco_pdois.save, "deveria salvar 2: #{@r_fum_fcinco_pum.errors.full_messages.join(', ')}")
		
		@r_fum_fcinco_pum.relacao   = :outra
		@r_fum_fcinco_pdois.relacao = :outra
		
		assert(!@r_fum_fcinco_pum.save)
		assert(!@r_fum_fcinco_pdois.save)
		
	end

	test "nao pode ser um relacionamento com a mesma funcionalidade" do
		@r_fum_fcinco_pum.funcionalidade_dois = @fum_pum
		assert(!@r_fum_fcinco_pum.save)


		@r_fum_fcinco_pdois.funcionalidade_dois = @fum_pdois
		assert(!@r_fum_fcinco_pdois.save)

	end

	test "as duas funcionalidades devem ser do mesmo produto" do
		r = RelacaoFuncionalidades.new(@r_fum_fcinco_pum.attributes)
		r.funcionalidade_dois = @fum_pdois
		assert(!r.save)

		r = RelacaoFuncionalidades.new(@r_fum_fcinco_pum.attributes)
		r.funcionalidade_dois = @fdois_pdois
		assert(!r.save)

		r = RelacaoFuncionalidades.new(@r_fum_fcinco_pdois.attributes)
		r.funcionalidade_dois = @fum_pum
		assert(!r.save)

		r = RelacaoFuncionalidades.new(@r_fum_fcinco_pdois.attributes)
		r.funcionalidade_dois = @fdois_pum
		assert(!r.save)
	end

	test "não pode haver 2 relacinoamentos iguais" do

		assert(@r_fum_fcinco_pum.save)

		duplicado = RelacaoFuncionalidades.new(@r_fum_fcinco_pum.attributes)
		assert(!duplicado.save, 'Não deveria salvar 1')

		duplicado = RelacaoFuncionalidades.new(@r_fum_fcinco_pum.attributes)
		duplicado.funcionalidade_um = @fcinco_pum
		duplicado.funcionalidade_dois = @fum_pum
		assert(!duplicado.save, 'Não deveria salvar 2')

	end

	test "visibildade nas funcionalidades" do

		assert(@r_fum_fcinco_pum.save)
		assert(@r_fum_fcinco_pdois.save)

		assert(@fum_pum.relacionamentos.include?(@r_fum_fcinco_pum))
		assert(@fcinco_pum.relacionamentos.include?(@r_fum_fcinco_pum))
		assert(@fum_pum.funcionalidades_relacionadas.include?(@fcinco_pum))
		assert(@fcinco_pum.funcionalidades_relacionadas.include?(@fum_pum))

		assert(@fum_pdois.relacionamentos.include?(@r_fum_fcinco_pdois))
		assert(@fcinco_pdois.relacionamentos.include?(@r_fum_fcinco_pdois))
		assert(@fum_pdois.funcionalidades_relacionadas.include?(@fcinco_pdois))
		assert(@fcinco_pdois.funcionalidades_relacionadas.include?(@fum_pdois))

	end

	test "buscar os relacinoamentos de um funcionalidade" do

		assert_equal(@fum_pum.relacionamentos, RelacaoFuncionalidades.da_funcionalidade(@fum_pum))

		assert_equal(@fdois_pdois.relacionamentos, RelacaoFuncionalidades.da_funcionalidade(@fdois_pdois))
	end

	test "remover os relacinoamentos quando deleta uma funcionalidade" do
		assert(@fum_pum.relacionamentos.size > 0, "para este teste funcionar a funcionalidade deve ter relacioamentos")

		@fum_pum.destroy
		@fdois_pdois.destroy

		assert(RelacaoFuncionalidades.da_funcionalidade(@fum_pum).count == 0)
		assert(RelacaoFuncionalidades.da_funcionalidade(@fdois_pdois).count == 0)
		
	end

	test "busca as funcionalidades ainda nao relacionadas 1" do
		todas = Funcionalidade.do_produto(@fum_pum.produto).where(["id != ?",@fum_pum.id])
		
		deve_ser = todas - @fum_pum.funcionalidades_relacionadas
				
		deve_ser.each do |f|
			assert(@fum_pum.funcionalidades_nao_relacionadas.include?(f))
		end
	end
	
	test "busca todas as funcionalidades nao relacionadas 2" do
		RelacaoFuncionalidades.destroy_all
		
		#todas as outras funcoinalidades do mesmo produto deve estar na lista de 
		# funcionalidades nao relacionadas
		deve_ser = Funcionalidade.do_produto(@fum_pum.produto).where(["id != ?",@fum_pum.id])
		
		assert_equal(deve_ser.size, @fum_pum.funcionalidades_nao_relacionadas.size)
		
		deve_ser.each do |f|
			assert(@fum_pum.funcionalidades_nao_relacionadas.include?(f))
		end
	end
	
	test "nas funcionalidades nao relacionadas nao pode ter a mesma funcionalidade" do
		assert(!@fum_pum.funcionalidades_nao_relacionadas.include?(@fum_pum))
	end

	test "busca relacao entre 2 funcionalidades" do
		
		assert_equal('fraca', @fum_pum.relacao_com(@fcinco_pum).to_s)
		assert_equal('fraca', @fcinco_pum.relacao_com(@fum_pum).to_s)
		
		assert_equal('fraca', @fum_pdois.relacao_com(@fcinco_pdois).to_s)
		assert_equal('fraca', @fcinco_pdois.relacao_com(@fum_pdois).to_s)

		assert_equal('forte', @fdois_pum.relacao_com(funcionalidades(:seis_produto_um)).to_s)
		assert_equal('forte', funcionalidades(:seis_produto_um).relacao_com(@fdois_pum).to_s)
		
		assert_equal('forte', @fdois_pdois.relacao_com(funcionalidades(:seis_produto_dois)).to_s)
		assert_equal('forte', funcionalidades(:seis_produto_dois).relacao_com(@fdois_pdois).to_s)
		
		assert_equal(false, @fum_pum.relacao_com(@fdois_pum))
		assert_equal(false, @fum_pum.relacao_com(@fdois_pdois))
	end
end
