# encoding: UTF-8

class Pesquisa < ActiveRecord::Base
	
	OPERADORES = {
		1 => :igual,
		2 => :maior,
		3 => :menor
	}
	
	belongs_to :indicador
	
  attr_accessible :indicador_id , :valor, :operador
  validates :operador, inclusion: {in: Pesquisa::OPERADORES.keys}
	
	def operador_nome
	  if self.operador.to_i > 1
      Pesquisa::OPERADORES[self.operador.to_i].to_s.humanize + " que"
    else
      Pesquisa::OPERADORES[self.operador.to_i].to_s.humanize + " a"
    end
	end
	
end