# encoding: UTF-8

class Projeto < ActiveRecord::Base
	
	attr_accessible :nome
	
	validates :nome, :presence => true
	
	has_many :indicador_projetos
	has_many :indicadors, :through => :indicador_projetos
	
	accepts_nested_attributes_for :indicador_projetos
	
end