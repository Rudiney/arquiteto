# encoding: UTF-8

class Projeto < ActiveRecord::Base
	
	attr_accessible :nome, :indicador_projetos_attributes
	
	validates :nome, :presence => true
	
	has_many :indicador_projetos, dependent: :destroy
	has_many :indicadors, :through => :indicador_projetos
	
	accepts_nested_attributes_for :indicador_projetos
	
	def satisfaz_pesquisa?(p)
		
		ip = self.indicador_projetos.where(indicador_id: p.indicador).first
		return false unless ip
		
		case p.operador.to_i
		when 1
			return p.valor_convertido == ip.valor_convertido
		when 2
			return ip.valor_convertido > p.valor_convertido
		when 3
			return ip.valor_convertido < p.valor_convertido
		end
	end
	
end