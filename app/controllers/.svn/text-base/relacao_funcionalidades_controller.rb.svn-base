# encoding: UTF-8

class RelacaoFuncionalidadesController < ApplicationController
	
	# espera os parâmetros :entre => funcionalidade, :e => outra_funcionalidade
	def novo

		@funcionalidade = Funcionalidade.find(params[:entre])
		
		@r = RelacaoFuncionalidades.new(
			funcionalidade_um_id:   params[:entre],
			funcionalidade_dois_id: params[:e],
			relacao:                params[:relacao]
		)
		
		@r.save
		
		respond_to do |f|
			f.js{render('atualiza_tabela_relacionamento')}
		end
		
	end

	def deleta
		@funcionalidade = Funcionalidade.find(params[:funcionalidade])
		@r = RelacaoFuncionalidades.find(params[:id])
		
		@r.destroy
		
		respond_to do |f|
			f.js{render('atualiza_tabela_relacionamento')}
		end
	end
	
	def mapa_impacto
		@funcionalidades = @produto_escolhido.funcionalidades
	end
end