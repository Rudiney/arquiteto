# encoding: UTF-8

class Projeto < ActiveRecord::Base
	
	validates :nome, :presence => true
	
	has_many :indicador_projetos
	
	has_many :indicadors, :through => :indicador_projetos
	
end