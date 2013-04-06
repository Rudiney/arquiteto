# encoding: UTF-8

class IndicadorProjeto < ActiveRecord::Base

	attr_accessible :projeto_id, :indicador_id, :projeto, :indicador, :valor
	
	belongs_to :projeto
	
	belongs_to :indicador
	
end