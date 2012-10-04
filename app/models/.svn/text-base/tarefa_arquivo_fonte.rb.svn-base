# encoding: UTF-8

class TarefaArquivoFonte < ActiveRecord::Base
	
	belongs_to :tarefa
	belongs_to :arquivo_fonte
	
	validates :tarefa_id, :arquivo_fonte_id, presence: true
	
	validates :tarefa_id, uniqueness:{ scope: :arquivo_fonte_id }
	
	validate :a_tarefa_deve_existir
	validate :o_arquivo_fonte_deve_existir
	validate :a_terefa_e_o_arquivo_fonte_devem_ser_do_mesmo_produto
	
	private
	
	def a_tarefa_deve_existir
		self.errors.add(:tarefa_id,'não existe') unless Tarefa.exists?(self.tarefa_id)
	end
	
	def o_arquivo_fonte_deve_existir
		self.errors.add(:arquivo_fonte_id,'não existe') unless ArquivoFonte.exists?(self.arquivo_fonte_id)
	end
	
	def a_terefa_e_o_arquivo_fonte_devem_ser_do_mesmo_produto
		return unless self.tarefa && self.arquivo_fonte
		
		self.errors.add(:arquivo_fonte_id,'deve ser do mesmo produto da tarefa') if self.tarefa.historia.produto != self.arquivo_fonte.produto
	end
	
end