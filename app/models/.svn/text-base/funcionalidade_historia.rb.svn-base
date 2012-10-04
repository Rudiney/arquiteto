# encoding: UTF-8

class FuncionalidadeHistoria < ActiveRecord::Base
	
	belongs_to :historia
	belongs_to :funcionalidade
	
	validates :historia_id, :funcionalidade_id, presence:true
	validates :historia_id, uniqueness: {scope: :funcionalidade_id}
	
	validate :valida_se_a_historia_e_a_funcionalidade_existem
	validate :valida_se_a_historia_e_a_funcionalidade_sao_do_mesmo_produto
	
	private
	
	def valida_se_a_historia_e_a_funcionalidade_existem
		self.errors.add(:historia_id,'Não existe') unless Historia.exists?(self.historia_id)
		self.errors.add(:funcionalidade_id,'Não existe') unless Funcionalidade.exists?(self.funcionalidade_id)
	end
	
	def valida_se_a_historia_e_a_funcionalidade_sao_do_mesmo_produto
		return unless self.historia && self.funcionalidade
		self.errors.add(:funcionalidade_id,'Deve ser do mesmo produto da historia') unless self.historia.produto == self.funcionalidade.produto
	end
end