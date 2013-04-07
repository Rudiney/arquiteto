# encoding: UTF-8

class IndicadorProjeto < ActiveRecord::Base
	
	include ValorDeIndicador
	
	attr_accessible :projeto_id, :indicador_id, :projeto, :indicador, :valor
	
	belongs_to :projeto
	
	belongs_to :indicador
	
end