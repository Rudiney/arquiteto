class IndicadorsController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	include Crud
	
	def initialize
		@modelo = Indicador
		super
	end
		
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'indicadors'
	end
end
