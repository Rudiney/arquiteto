class HistoriaAnexosController < ApplicationController
	
	def novo
		@historia = Historia.find(params[:id])

		anexo = @historia.anexos.new(params[:anexo])
		
		anexo.save!
		
		redirect_to(historia_path(@historia_path))
	end
	
	def deleta
		@historia = Historia.find(params[:historia])
		
		anexo = @historia.anexos.find(params[:id])
		
		anexo.destroy
		
		respond_to do |f|
			f.js{render('atualiza_tabela_anexos')}
		end
	end
	
end