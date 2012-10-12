class HistoriasController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def show 
		@historia = Historia.do_produto(@produto_escolhido).find(params[:id])
	end
	
	def new
		@historia = Historia.do_produto(@produto_escolhido).new
	end
	
	def create
		@historia = Historia.new(params[:historia])
		@historia.produto = @produto_escolhido
		
		if @historia.save
			redirect_to @historia, notice: 'Sucesso!'
		else
			render action: 'new'
		end
	end
	
	def edit
		@historia = Historia.do_produto(@produto_escolhido).find(params[:id])
	end
	
	def update
		@historia = Historia.do_produto(@produto_escolhido).find(params[:id])
		
		if @historia.update_attributes(params[:historia])
			params['voltar_para'] ? redirect_to(controller: params['voltar_para']) : redirect_to(@historia, notice: 'Sucesso!')
		else
			render action: 'edit'
		end
	end
	
	def destroy
		@historia = Historia.do_produto(@produto_escolhido).find(params[:id])
		@historia.destroy
		redirect_to controller: :backlog
	end



	private 
	
	def escolhe_item_menu
		@menu_ativo = 'backlog'
	end
	
end