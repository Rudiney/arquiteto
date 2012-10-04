# encoding: UTF-8

class Tarefa < ActiveRecord::Base
	
	validates :historia_id, :descricao, presence:true
	validates :descricao, length:{ maximum: 255 }
	
	validate :valida_uma_historia_que_exista
	
	belongs_to :historia

	has_many :tarefas_arquivos_fonte, :class_name => 'TarefaArquivoFonte', :dependent => :destroy
	has_many :arquivos_fonte, :through => :tarefas_arquivos_fonte
	
	def identificador
		return "#{self.historia.id}.#{self.id}"
	end
	
	def tempo_estimado=(tempo)
		self.segundos_estimados = tempo.em_segundos
	end
	def tempo_estimado
		self.segundos_estimados.em_horas
	end

	def tempo_real=(tempo)
		self.segundos_reais = tempo.em_segundos
	end	
	def tempo_real
		self.segundos_reais.em_horas
	end
	
	def segundos_diferenca_estimativa
		self.segundos_estimados - self.segundos_reais
	end
	
	def diferenca_estimativa
		self.segundos_diferenca_estimativa.em_horas
	end
	
	def produto
		self.historia.produto
	end
	
	private 
	
	def valida_uma_historia_que_exista
		self.errors.add(:historia_id, "não existe") unless Historia.exists?(self.historia_id)
	end
end