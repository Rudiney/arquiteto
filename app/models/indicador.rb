# encoding: UTF-8

class Indicador < ActiveRecord::Base
	
	TIPOS = {"Numero" => "numero", "Duração" => "duracao", "Data" => "data"}
	
	validates :nome, :presence => true
	
	attr_accessible :tipo, :nome
	
	has_many :indicador_projetos, dependent: :destroy
	has_many :projetos, :through => :indicador_projetos
	
	has_many :pesquisas
	
	
	def data?
	  self.tipo == 'data'
  end  
end