# encoding: UTF-8

class Indicador < ActiveRecord::Base
	
	#validates :nome, :presence => true
	
	attr_accessible :tipo, :nome
	has_many :indicador_projetos
	
	has_many :projetos, :through => :indicador_projetos
	
end