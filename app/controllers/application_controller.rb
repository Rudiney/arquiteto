class ApplicationController < ActionController::Base
	protect_from_forgery
	
	before_filter :authenticate_user!
	
	def deve_escolher_um_produto
		@produto_escolhido = Produto.find_by_id(session[:produto_id])
		redirect_to(escolha_um_produto_path) unless @produto_escolhido
	end
end
