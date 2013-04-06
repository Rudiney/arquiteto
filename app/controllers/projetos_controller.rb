class ProjetosController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	include Crud
	
	def initialize
		@modelo = Projeto
		super
	end
		
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'projetos'
	end
	
end
