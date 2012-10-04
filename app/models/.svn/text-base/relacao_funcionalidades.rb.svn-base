# encoding: UTF-8

class RelacaoFuncionalidades < ActiveRecord::Base
	
	TIPOS_RELACAO = ['forte','fraca']
	
	belongs_to :funcionalidade_um,   class_name: "Funcionalidade", foreign_key: "funcionalidade_um_id"
	belongs_to :funcionalidade_dois, class_name: "Funcionalidade", foreign_key: "funcionalidade_dois_id"
	
	# Busca todos os relacionamentos de uma funcionalidade.
	# escopo necessário pois deve retornar tando os relacionamentos de A para B quanto de B para A
	scope :da_funcionalidade, lambda{ |f|
		funcionalidades = []
		funcionalidades += RelacaoFuncionalidades.where(:funcionalidade_um_id => f)
		funcionalidades += RelacaoFuncionalidades.where(:funcionalidade_dois_id => f)
		return funcionalidades
	}
	
	validates :funcionalidade_um_id, :funcionalidade_dois_id, :relacao, :presence => true
	
	validates :relacao, inclusion: { in: RelacaoFuncionalidades::TIPOS_RELACAO}
	
	# se tem relacao entre A e B, não pode ter entre B e A
	validates_uniqueness_of :funcionalidade_dois_id, :scope => :funcionalidade_um_id
	validates_uniqueness_of :funcionalidade_um_id, :scope => :funcionalidade_dois_id
	
	validate :valida_se_as_funcionalidades_sao_iguais
	validate :as_duas_funcionalidades_devem_ser_do_mesmo_produto
	validate :valida_as_funcionalidades_iguais_mesmo_ao_contrario
	
	private
	
	def valida_se_as_funcionalidades_sao_iguais
		if self.funcionalidade_um_id == self.funcionalidade_dois_id
			self.errors.add(:funcionalidade_dois_id, 'as funcionalidades devem ser iguais') 
		end
	end
	
	def as_duas_funcionalidades_devem_ser_do_mesmo_produto
		return unless self.funcionalidade_um && self.funcionalidade_dois
		if self.funcionalidade_um.produto != self.funcionalidade_dois.produto
			self.errors.add(:funcionalidade_dois_id, 'as duas funcionalidades devem ser do mesmo produto')
		end
	end
	
	# se já existe um relacionamento de A para B, não posso deixar inserir um relacionamento
	# de B para A
	def valida_as_funcionalidades_iguais_mesmo_ao_contrario
		existe = RelacaoFuncionalidades.exists?({
			funcionalidade_um_id: self.funcionalidade_dois_id, 
			funcionalidade_dois_id: self.funcionalidade_um_id
		})

		self.errors.add(:funcionalidade_um_id, 'Já existe este relacionamento') if existe
	end
end