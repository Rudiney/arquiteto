# encoding: UTF-8

class IndicadorProjeto < ActiveRecord::Base
	
	belongs_to :projeto
	
	belongs_to :indicador
	
  attr_accessible :projeto_id, :indicador_id
  
  attr_accessible :valor
	
end