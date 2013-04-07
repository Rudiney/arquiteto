class IndicadorsController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	include Crud
	
	def initialize
		@modelo = Indicador
		super
	end
		
	def carrega_variaveis
		Projeto.all.each do |projeto|
			next if @indicador.projetos.include?(projeto)
			@indicador.indicador_projetos.build(projeto: projeto)
		end
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'indicadors'
	end
end
