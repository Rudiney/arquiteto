# encoding: UTF-8

require 'test_helper'

class RelacaoTecnicaFuncionalidadesTest < ActiveSupport::TestCase
	
	setup do
			
		# 2 funcionalidades sem relacao técnica nenhuma ainda
		@fum   = funcionalidades(:um_produto_um)
		@fdois = funcionalidades(:dez_produto_um)
		
		@hum   = @fum.historias.first
		@hdois = @fdois.historias.last
		
		@tum   = @hum.tarefas.last
		@tdois = @hdois.tarefas.first

		@afum   = @tum.arquivos_fonte.first
		@afdois = @tdois.arquivos_fonte.last 
	end
	
	test "as funcioanlidades do setup nao podem ter relacao tecnica nenhuma" do
		@fum.historias.each do |hum|
			hum.tarefas.each do |tum|
				tum.arquivos_fonte.each do |afum|
					@fdois.historias.each do |hdois|
						hdois.tarefas.each do |tdois|
							assert(!tdois.arquivos_fonte.include?(afum))
						end
					end
				end
			end
		end
	end
	
	test "1 arquivo de 2 funcionalidades" do
		
		@tum.arquivos_fonte << @afdois
		
		assert_equal(2, @fum.funcionalidades_relacionadas_tecnicamente.size, "a funcionalidade um deveria ter 2 relacao tecnica")
		assert_equal(2, @fdois.funcionalidades_relacionadas_tecnicamente.size, "a funcionalidade dois deveria ter 2 relacao tecnica")
		
		assert(@fum.funcionalidades_relacionadas_tecnicamente.include?(@fdois))
		assert(@fdois.funcionalidades_relacionadas_tecnicamente.include?(@fum))
		
		# 3 funcionalidades = a história 11 tem 2 funcionalidades
		assert_equal(3, @afdois.funcionalidades.size, "o arquivo fonte deveria ter 3 funcionalidades!")
		
		assert(@afdois.funcionalidades.include?(@fum), "A funcionalidade um deveria estar relacionada ao arquivo fonte um")
		assert(@afdois.funcionalidades.include?(@fdois), "A funcionalidade dois deveria estar relacionada ao arquivo fonte um")
		
	end
	
	test "vários arquivos comuns" do
		@tum.arquivos_fonte.each do |aftum|
			@tdois.arquivos_fonte << aftum

			# nao pode duplicar os relacionamentos, mesmo com vários arquivos comuns
			assert_equal(2, @fum.funcionalidades_relacionadas_tecnicamente.size)
			assert_equal(2, @fdois.funcionalidades_relacionadas_tecnicamente.size)

			
			assert(@fum.funcionalidades_relacionadas_tecnicamente.include?(@fdois))
			assert(@fdois.funcionalidades_relacionadas_tecnicamente.include?(@fum))
			
		end
	end
end
