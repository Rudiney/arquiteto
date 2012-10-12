# encoding: UTF-8

class RepositorioController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def edit
		@repositorio = @produto_escolhido.repositorio || Repositorio.new
	end
	
	def update
		@repositorio = @produto_escolhido.repositorio || Repositorio.new
		@repositorio.produto = @produto_escolhido
		
		if @repositorio.update_attributes(params[:repositorio])
			flash[:sucesso] = 'Sucesso!'
			redirect_to(action: :edit)
		else
			render(:edit)
		end
	end
	
	def importa_arquivos
		begin
			
			@importacao = ImportaArquivosRepositorio.new(repositorio: @produto_escolhido.repositorio)

			@importacao.importa!
			
			respond_to do |format|
				format.js{render("sucesso_na_importacao")}
			end
			
		rescue Exception => @e
			respond_to do |format|
				format.js{render("erro_importacao")}
			end					
		end
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'repositorio'
	end
	
end