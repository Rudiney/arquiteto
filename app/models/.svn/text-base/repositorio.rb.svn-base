# encoding: UTF-8

class Repositorio < ActiveRecord::Base
	
	belongs_to :produto
	
	validates :endereco, :produto_id, presence: true
	validates :produto_id, uniqueness:true
	validates :endereco, length:{ maximum:255 }
	
	validate :valida_se_o_produto_existe
	
	def comando_buscar_log_xml
		@comando_buscar_log_xml ||= "svn log #{self.endereco} --xml --verbose -r HEAD:#{self.ultima_revisao_importada}"
	end
	
	def log_xml
		@log_xml ||= busca_log_xml
	end
	
	# permite atribuir um log específico para o repositório, util principalmente nos testes.
	def log_xml=(log)
		@log_xml = log
	end
		
	private 
	
	def valida_se_o_produto_existe
		self.errors.add(:produto_id,'não existe') unless Produto.exists?(self.produto_id)
	end
	
	# faz o comando no servidor para buscar o log do repositorio
	def busca_log_xml
		return `#{self.comando_buscar_log_xml}`
	end
end