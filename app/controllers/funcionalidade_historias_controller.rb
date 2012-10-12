# encoding: UTF-8

class FuncionalidadeHistoriasController < ApplicationController
	before_filter :deve_escolher_um_produto
	
	def novo
		
		@historia = Historia.find(params[:entre])
		
		@relacao = FuncionalidadeHistoria.new(
			historia_id:       params[:entre],
			funcionalidade_id: params[:e],
		)
		
		@relacao.save
		
		respond_to do |f|
			f.js{render('atualiza_tabela_funcionalidades')}
		end
		
	end
	
	def deleta
		
		@historia = Historia.find(params[:historia])
		
		@relacao = FuncionalidadeHistoria.find(params[:id])
		
		@relacao.destroy
		
		respond_to do |f|
			f.js{render('atualiza_tabela_funcionalidades')}
		end
		
	end
end