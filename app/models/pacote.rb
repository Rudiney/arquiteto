# encoding: UTF-8

class Pacote < ActiveRecord::Base
	
	belongs_to :produto
	
	validates :produto_id, :nome, :presence => true
	
	has_many :historias
	
	validate :valida_se_o_produto_existe

	def nome_exibicao
		"#{self.id}) #{self.nome}"
	end
	
	private
	
	def valida_se_o_produto_existe
		self.errors.add(:produto_id, 'não existe!') unless Produto.exists?(self.produto_id)
	end
	
end
