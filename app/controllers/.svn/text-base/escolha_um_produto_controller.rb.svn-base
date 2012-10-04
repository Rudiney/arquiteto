class EscolhaUmProdutoController < ApplicationController
	skip_before_filter :deve_escolher_um_produto
	
	def index
		if session[:produto_id] # não utiliza a @produto_escolhido por causa do skip_before_filter
			redirect_to(controller: :backlog)
		else
			if Produto.count == 1
				escolhe_o_produto(Produto.first)
				redirect_to(controller: :backlog)
			end
		end
		@produtos = Produto.all
	end
	
	def escolhido
		if p = Produto.find_by_id(params[:id])
			escolhe_o_produto(p)
			redirect_to(controller: :backlog)
		else
			redirect_to :action => :index
		end
	end
	
	def sai_do_produto_atual
		if Produto.count == 1
			redirect_to(controller: :backlog)
		else
			session[:produto_id] = nil
			redirect_to :action => :index
		end
	end
	
	private
	
	def escolhe_o_produto(produto)
		session[:produto_id] =  produto.id
	end
end