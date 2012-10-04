class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :deve_escolher_um_produto 
	
	def deve_escolher_um_produto
		@produto_escolhido = Produto.find_by_id(session[:produto_id])
		
		redirect_to(controller: :escolha_um_produto) unless @produto_escolhido
	end
end
