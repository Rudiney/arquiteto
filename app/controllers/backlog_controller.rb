class BacklogController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def index
		@historias = @produto_escolhido.historias.order('situacao,prioridade')
		@pacotes = @produto_escolhido.pacotes
		filtra_historias()
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'backlog'
	end
	
	def filtra_historias
		
		@filtrou = (params['filtros']||{}).symbolize_keys
		
		
		@historias = @historias.where(id: @filtrou[:id]) unless @filtrou[:id].blank?
		@historias = @historias.where(['nome ILIKE ?',"%#{@filtrou[:nome]}%"]) unless @filtrou[:nome].blank?

		
		@filtrou[:situacao] ||= {}
		@filtrou[:tamanho] ||= {}
		@filtrou[:pacotes] ||= {}
		
		@historias = @historias.where(situacao: @filtrou[:situacao].keys) unless @filtrou[:situacao].blank?
		@historias = @historias.where(tamanho: @filtrou[:tamanho].keys)   unless @filtrou[:tamanho].blank?
		@historias = @historias.where(pacote_id: @filtrou[:pacotes])  unless @filtrou[:pacotes].blank?

	end
end