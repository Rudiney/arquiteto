class FuncionalidadesController < ApplicationController
	
	before_filter :escolhe_item_menu
	
	def index
		@funcionalidades = Funcionalidade.do_produto(@produto_escolhido).all
	end
	
	def show 
		@funcionalidade = Funcionalidade.do_produto(@produto_escolhido).find(params[:id])
	end
	
	def new
		@funcionalidade = Funcionalidade.do_produto(@produto_escolhido).new
	end
	
	def create
		@funcionalidade = Funcionalidade.new(params[:funcionalidade])
		@funcionalidade.produto = @produto_escolhido
		
		if @funcionalidade.save
			redirect_to @funcionalidade, notice: 'Sucesso!'
		else
			render action: 'new'
		end
	end
	
	def edit
		@funcionalidade = Funcionalidade.do_produto(@produto_escolhido).find(params[:id])
	end
	
	def update
		@funcionalidade = Funcionalidade.do_produto(@produto_escolhido).find(params[:id])
		
		if @funcionalidade.update_attributes(params[:funcionalidade])
			redirect_to @funcionalidade, notice: 'Sucesso!'
		else
			render action: 'edit'
		end
	end
	
	def destroy
		@funcionalidade = Funcionalidade.do_produto(@produto_escolhido).find(params[:id])
		@funcionalidade.destroy
		redirect_to funcionalidades_url
	end



	private 
	
	def escolhe_item_menu
		@menu_ativo = 'funcionalidades'
	end
	
end